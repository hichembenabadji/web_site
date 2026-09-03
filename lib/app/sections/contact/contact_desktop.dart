import 'package:flutter/material.dart';
import 'package:mysite/app/widgets/custom_text_heading.dart';
import 'package:mysite/app/widgets/social_icons.dart';
import 'package:mysite/changes/links.dart';
import 'package:mysite/changes/strings.dart';
import 'package:mysite/core/color/colors.dart';
import 'package:mysite/core/configs/configs.dart';
import 'package:mysite/core/util/constants.dart';
import 'package:sizer/sizer.dart';

class ContactDesktop extends StatelessWidget {
  const ContactDesktop({Key? key}) : super(key: key);

  /// Breathing room between the heading block and the button on each side.
  static const double _buttonGap = 24;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width / 8),
      child: Column(
        children: [
          const CustomSectionHeading(text: "\nGet in Contact"),
          Space.y(1.w)!,
          const CustomSectionSubHeading(
            text: "To access my services, use the contact details below.",
          ),
          Space.y(2.w)!,
          Container(
            padding: EdgeInsets.all(size.width * 0.05).copyWith(bottom: 0),
            decoration: BoxDecoration(
              gradient: theme.contactCard,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [redColorShadow],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Balanced row: an invisible twin of the button on the left
                // reserves exactly the same width as the real button on the
                // right, so the heading block is centred on the card axis
                // (same axis as the icons row) and can never be overlapped.
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: false,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: _contactButton(),
                    ),
                    const SizedBox(width: _buttonGap),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            contactHeadding,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 1.2,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Space.y(1.w)!,
                          Text(
                            contactSubHeadding,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: _buttonGap),
                    _contactButton(),
                  ],
                ),
                Space.y(2.w)!,
                Container(color: Colors.white.withValues(alpha: 0.2), height: 1),
                // Same space above and below: the row sits exactly halfway
                // between the separator line and the bottom of the card.
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.w),
                  child: const SocialIconsRow(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactButton() {
    return InkWell(
      onTap: () {
        openURL(contact);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(gradient: buttonGradi, borderRadius: BorderRadius.circular(10)),
        child: const Text(
          'Contact Me',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
