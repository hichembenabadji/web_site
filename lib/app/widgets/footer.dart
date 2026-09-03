import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mysite/app/widgets/marquee_text.dart';
import 'package:mysite/changes/links.dart';
import 'package:mysite/core/util/constants.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  late final TapGestureRecognizer _authorTap = TapGestureRecognizer()
    ..onTap = () => openURL(gitHub);

  @override
  void dispose() {
    _authorTap.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.05),
      height: size.height * 0.07,
      width: size.width,
      alignment: Alignment.center,
      child: MarqueeText(
        text: TextSpan(
          children: <InlineSpan>[
            const TextSpan(text: 'Made with Flutter Web by '),
            TextSpan(
              text: 'Hichem Benabadji',
              style: const TextStyle(fontWeight: FontWeight.bold),
              recognizer: _authorTap,
              mouseCursor: SystemMouseCursors.click,
            ),
            TextSpan(
              text: ' © ${DateTime.now().year}. All rights reserved.',
            ),
          ],
        ),
      ),
    );
  }
}
