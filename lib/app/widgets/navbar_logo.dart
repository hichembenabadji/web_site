import 'package:flutter/material.dart';
import 'package:mysite/core/configs/configs.dart';
import 'package:mysite/core/res/responsive.dart';
import 'package:google_fonts/google_fonts.dart';


class NavBarLogo extends StatelessWidget {
  const NavBarLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textSty = TextStyle(
      color: theme.textColor,
      fontWeight: FontWeight.w100,
      fontSize: Responsive.isDesktop(context) ? 32 : 20,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("", style: textSty),
        Text(
          "Hichem Benabadji",
          style: GoogleFonts.pacifico(
            fontSize: Responsive.isDesktop(context) ? 32 : 20,
          ),
        ),
      ],
    );
  }
}
