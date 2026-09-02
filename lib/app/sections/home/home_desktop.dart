import 'package:mysite/app/sections/home/widgets/animation_text.dart';
import 'package:mysite/core/animations/zoom_animation.dart';
import 'package:mysite/core/res/responsive_size.dart';
import 'package:sizer/sizer.dart';
import 'package:universal_html/html.dart' as html;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:mysite/app/widgets/color_chage_btn.dart';
import 'package:mysite/changes/links.dart';
import 'package:mysite/changes/strings.dart';
import 'package:mysite/core/configs/configs.dart';

class HomeDesktop extends StatelessWidget {
  const HomeDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SizedBox(
      height: 80.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.h),
              width: 55.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        hellotag,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ],
                  ),
                  Space.y(0.5.w)!,
                  Text(
                    yourname,
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      AnimatedTextKit(
                        isRepeatingAnimation: true,
                        repeatForever: true,
                        animatedTexts: desktopList,
                      ),
                    ],
                  ),
                  Space.y(1.5.w)!,
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Text(miniDescription,
                        style: TextStyle(
                          fontSize: isFontSize(context, 20),
                          fontWeight: FontWeight.w400,
                          color: theme.textColor.withValues(alpha: 0.6),
                        )),
                  ),
                  Space.y(3.w)!,
                  ColorChageButton(
                    text: 'My Resume CV',
                    onTap: () {
                      html.window.open(resume, "pdf");
                    },
                  ),
                ],
              ),
            ),
            const ZoomAnimations(),
          ],
        ),
      ),
    );
  }
}
