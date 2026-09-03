import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Scrolls [text] horizontally, right to left, in a continuous seamless loop.
///
/// The text is measured with a [TextPainter] and repeated as many times as
/// needed to cover the available width, separated by [gap]. The strip is then
/// translated by `elapsed * velocity` modulo one period, so the loop never
/// shows a blank area or a visible jump. Both edges are softened by a
/// transparent fade of [fadeWidth] pixels.
///
/// Gesture recognizers attached to child spans (e.g. a tappable name) keep
/// working while the text moves. When the platform asks for reduced motion,
/// the text is simply centered without any animation.
class MarqueeText extends StatefulWidget {
  const MarqueeText({
    super.key,
    required this.text,
    this.style,
    this.velocity = 40,
    this.gap = 72,
    this.fadeWidth = 32,
  });

  /// The (rich) text to scroll.
  final InlineSpan text;

  /// Base style, merged over the ambient [DefaultTextStyle].
  final TextStyle? style;

  /// Scrolling speed, in logical pixels per second.
  final double velocity;

  /// Blank space between two repetitions of [text], in logical pixels.
  final double gap;

  /// Width of the transparent fade on each edge. `0` disables the fade.
  final double fadeWidth;

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final ValueNotifier<double> _elapsedSeconds = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
  }

  void _onTick(Duration elapsed) {
    _elapsedSeconds.value =
        elapsed.inMicroseconds / Duration.microsecondsPerSecond;
  }

  @override
  void dispose() {
    _ticker.dispose();
    _elapsedSeconds.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextDirection direction = Directionality.of(context);
    final TextScaler scaler = MediaQuery.textScalerOf(context);
    TextStyle style = DefaultTextStyle.of(context).style.merge(widget.style);
    if (MediaQuery.boldTextOf(context)) {
      style = style.merge(const TextStyle(fontWeight: FontWeight.bold));
    }

    if (MediaQuery.disableAnimationsOf(context)) {
      if (_ticker.isActive) _ticker.stop();
      return Text.rich(
        widget.text,
        style: style,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      );
    }
    if (!_ticker.isActive) _ticker.start();

    final TextPainter painter = TextPainter(
      text: TextSpan(style: style, children: <InlineSpan>[widget.text]),
      textDirection: direction,
      textScaler: scaler,
      maxLines: 1,
    )..layout();
    final double textWidth = painter.width;
    final double textHeight = painter.height;
    painter.dispose();

    final double period = textWidth + widget.gap;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double viewportWidth =
            constraints.maxWidth.isFinite ? constraints.maxWidth : textWidth;
        final int copies = (viewportWidth / period).ceil() + 1;

        // Rasterized once, then only translated frame after frame.
        final Widget strip = RepaintBoundary(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (int i = 0; i < copies; i++) ...<Widget>[
                if (i > 0) SizedBox(width: widget.gap),
                Text.rich(
                  widget.text,
                  style: style,
                  maxLines: 1,
                  softWrap: false,
                  textDirection: direction,
                  textScaler: scaler,
                ),
              ],
            ],
          ),
        );

        Widget marquee = ClipRect(
          child: SizedBox(
            width: viewportWidth,
            height: textHeight,
            child: OverflowBox(
              alignment: Alignment.centerLeft,
              minWidth: 0,
              maxWidth: double.infinity,
              child: ValueListenableBuilder<double>(
                valueListenable: _elapsedSeconds,
                child: strip,
                builder: (BuildContext context, double seconds, Widget? child) {
                  final double offset = (seconds * widget.velocity) % period;
                  return Transform.translate(
                    offset: Offset(-offset, 0),
                    child: child,
                  );
                },
              ),
            ),
          ),
        );

        if (widget.fadeWidth > 0 && viewportWidth > 0) {
          final double fade =
              (widget.fadeWidth / viewportWidth).clamp(0.0, 0.5);
          marquee = ShaderMask(
            blendMode: BlendMode.dstIn,
            shaderCallback: (Rect bounds) => LinearGradient(
              colors: const <Color>[
                Color(0x00FFFFFF),
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
                Color(0x00FFFFFF),
              ],
              stops: <double>[0, fade, 1 - fade, 1],
            ).createShader(bounds),
            child: marquee,
          );
        }

        // Keeps the per-frame repaint confined to the marquee itself.
        return RepaintBoundary(child: marquee);
      },
    );
  }
}
