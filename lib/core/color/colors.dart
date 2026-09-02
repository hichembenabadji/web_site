import 'package:flutter/material.dart';

const primaryColor = Colors.white;
const secondaryColor = Colors.blue;

const textColor = Color(0xFF2B2B2B);
const lightgrayColor = Color(0x44948282);
const whiteColor = Color(0xFFFFFFFF);
const blackColor = Color(0xFF2B2B2B);


Color lightBackgroundColor = const Color(0xFFFFFFFF);
Color lightTextColor = const Color(0xFF403930);

Color darkBackgroundColor = const Color(0xFF2B2B2B);
Color darkTextColor = const Color(0xFFF3F2FF);

const brown = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomRight,
  colors: [Color(0xFFA1887F), Colors.brown],
);

const grayBack = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0XFF424242), Color(0XFF424242)],
);
const grayWhite = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFFFFF), Color(0xFFF3F2FF)],
);

const buttonGradi = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Colors.white, Colors.white70],
);

const contactGradi = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0XFF424242), Color(0XFF424242)],
);

BoxShadow primaryColorShadow = BoxShadow(
  color: primaryColor.withAlpha(100),
  blurRadius: 12.0,
  offset: const Offset(0.0, 0.0),
);
BoxShadow redColorShadow = const BoxShadow(
  color: Color(0xFFF3F2FF),
  blurRadius: 10.0,
  offset: Offset(0.0, 0.0),
);
