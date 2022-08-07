import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color.dart';

class AppStyles {
  AppStyles._();

  static TextStyle textStyleDefault(
          {Color? color = colorWhite,
          FontStyle? fontStyle,
          double? size = 12,
          double? height,
          FontWeight? fontWeight,
          TextDecoration? decoration}) =>
      GoogleFonts.montserrat(
          height: height,
          color: color,
          fontSize: size,
          fontStyle: fontStyle,
          fontWeight: fontWeight,
          decoration: decoration);

  static LinearGradient bgGradient([List<Color> colors = colorGradient]) =>
      LinearGradient(
          colors: colors, begin: Alignment.center, end: Alignment.bottomCenter);

}
