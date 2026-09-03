import 'package:flutter/material.dart';
import 'package:mysite/app/utils/contact_utils.dart';
import 'package:mysite/core/theme/app_theme.dart';
import 'package:mysite/core/util/constants.dart';

/// Horizontal list of social-network buttons, in the order of [contactUtils].
///
/// The remote icons have different intrinsic sizes (48 to 64 px), so every
/// glyph is scaled into the same [iconSize] square and placed inside an
/// identical [boxSize] tap target: all icons look equally big.
class SocialIconsRow extends StatelessWidget {
  const SocialIconsRow({
    super.key,
    this.iconSize = 30,
    this.boxSize = 56,
    this.spacing = 16,
    this.runSpacing = 16,
  });

  /// Visual size of the glyph itself.
  final double iconSize;

  /// Size of the square tap target that contains the glyph.
  final double boxSize;

  /// Horizontal space between two buttons.
  final double spacing;

  /// Vertical space between rows when the buttons need to wrap.
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).textColor;
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: spacing,
      runSpacing: runSpacing,
      children: <Widget>[
        for (final ContactUtils item in contactUtils)
          SocialIconButton(
            item: item,
            color: color,
            iconSize: iconSize,
            boxSize: boxSize,
          ),
      ],
    );
  }
}

/// A single social-network button drawn inside a fixed square box.
class SocialIconButton extends StatelessWidget {
  const SocialIconButton({
    super.key,
    required this.item,
    required this.color,
    this.iconSize = 30,
    this.boxSize = 56,
  });

  final ContactUtils item;
  final Color color;
  final double iconSize;
  final double boxSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: boxSize,
      child: IconButton(
        onPressed: () => openURL(item.url),
        tooltip: item.name,
        padding: EdgeInsets.zero,
        iconSize: iconSize,
        highlightColor: Colors.white54,
        icon: SizedBox.square(
          dimension: iconSize,
          child: Image.network(
            item.icon,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,
            color: color,
            filterQuality: FilterQuality.medium,
            excludeFromSemantics: true,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.link, size: iconSize, color: color),
          ),
        ),
      ),
    );
  }
}
