import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const double borderradius1 = 30;
  static const double borderradiu2 = 15;
  static const double borderradiu3 = 5;
  static const double elevation = 3;
  static const EdgeInsets marginall =
      EdgeInsets.only(left: 15, right: 15, bottom: 7, top: 7);
  static const EdgeInsets paddingall =
      EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15);
  static const double height1 = 30;
  static const double height2 = 15;
  static const Color iconColor = Colors.white;

  static const Color mainColor = Colors.white;
  static const Color secondColor = Color(0xff50B04F);
  static const Color secondGreyColor = Colors.grey;

  static const Color sucess = Color.fromARGB(255, 4, 99, 7);
  static double dynamicH(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double dynamicW(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static const Gradient mainGradient = LinearGradient(colors: [
    Color(0xff50B04F),
    Color((0xff69C144)),
  ], begin: Alignment.center, end: Alignment.bottomCenter);
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline1: GoogleFonts.openSans(
      fontSize: 37.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline2: GoogleFonts.openSans(
      fontSize: 19.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline3: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline4: GoogleFonts.openSans(
      fontSize: 15.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline5: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline6: GoogleFonts.openSans(
      fontSize: 11.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );
  static ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(color: secondColor),
     unselectedWidgetColor: mainColor,
    
      iconTheme: const IconThemeData(color:mainColor,opacity:1),
      
      textTheme: lightTextTheme);
}
