import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kBackground = Color(0xff131313);
const Color kPrimary = Color(0xffFFF500);
const Color kSecondery = Color(0xff2C2D35);
const Color kGrey = Color(0xffD9D9D9);
const Color kWhite = Colors.white;

final TextStyle kHeading2 = GoogleFonts.poppins(
  fontSize: 40,
  fontWeight: FontWeight.bold,
);
final TextStyle kHeading3 = GoogleFonts.poppins(
  fontSize: 28,
  fontWeight: FontWeight.bold,
);
final TextStyle kHeading4 = GoogleFonts.poppins(
  fontSize: 26,
  fontWeight: FontWeight.w600,
);
final TextStyle kHeading5 = GoogleFonts.poppins(
  fontSize: 23,
  fontWeight: FontWeight.w400,
);
final TextStyle kHeading6 = GoogleFonts.poppins(
  fontSize: 19,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.15,
);
final TextStyle kSubtitle = GoogleFonts.poppins(
  fontSize: 15,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.15,
);
final TextStyle kBodyText = GoogleFonts.poppins(
  fontSize: 13,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
);

final kTextTheme = TextTheme(
  displayMedium: kHeading2,
  displaySmall: kHeading3,
  headlineMedium: kHeading4,
  headlineSmall: kHeading5,
  titleLarge: kHeading6,
  titleMedium: kSubtitle,
  bodyMedium: kBodyText,
);

const kColorScheme = ColorScheme(
  primary: kPrimary,
  primaryContainer: kPrimary,
  secondary: kSecondery,
  secondaryContainer: kSecondery,
  surface: kBackground,
  background: kBackground,
  error: Colors.red,
  onPrimary: kBackground,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.dark,
);

class AppSize {
  static const double padding = 20;
  static const double marginTop = 15;
}

class AppRadius {
  static const double radius = 12;
}
