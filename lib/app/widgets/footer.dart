import 'package:flutter/material.dart';
import 'package:mysite/changes/links.dart';
import 'package:mysite/core/res/responsive.dart';
import 'package:mysite/core/util/constants.dart';
import 'package:text_scroll/text_scroll.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: _desktop(context),
      tablet: _desktop(context),
      mobile: _mobile(context),
    );
  }

  Widget _mobile(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
      height: height * 0.07,
      width: width,
      child: const Center(
        child: TextScroll("Made with Flutter Web \u2665 by Hichem Benabadji  © 2023"),
      ),
    );
  }

  Widget _desktop(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
      height: height * 0.07,
      width: width,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Made with Flutter Web \u2665 by "),
            InkWell(
              onTap: () => openURL(gitHub),
              child: const Text(
                "Hichem Benabadji",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Text(" © 2023"),
          ],
        ),
      ),
    );
  }
}
