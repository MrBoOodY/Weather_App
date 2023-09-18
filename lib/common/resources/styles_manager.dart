import 'package:flutter/widgets.dart';
import 'package:weath_app/common/resources/font_manager.dart';

//TextStyle builder method
TextStyle _getTextStyle({
  double? fontSize,
  String? fontFamily,
  Color? color,
  FontWeight? fontWeight,
  TextOverflow? textOverflow,
  TextDecoration decoration = TextDecoration.none,
  Color? decorationColor,
  double? height,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    decorationColor: decorationColor,
    letterSpacing: .5,
    decoration: decoration,
    fontWeight: fontWeight,
    overflow: textOverflow,
    height: height,
  );
}

class StylesManager {
  /// extraLight TextStyle
  static TextStyle extraLight(
      {double fontSize = 10,
      Color? color,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
      fontSize: fontSize,
      decoration: decoration,
      fontFamily: FontNames.fontName,
      color: color,
      fontWeight: FontWeights.extraLight,
    );
  }

  /// Light TextStyle = FontWeight.w300
  static TextStyle light(
      {double fontSize = 10,
      Color? color,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
        fontSize: fontSize,
        fontFamily: FontNames.fontName,
        decoration: decoration,
        textOverflow: TextOverflow.ellipsis,
        color: color,
        fontWeight: FontWeights.light);
  }

  ///regular TextStyle = [FontWeight.w400],[FontWeight.normal]
  static TextStyle regular(
      {double fontSize = 16,
      Color? color,
      Color? decorationColor,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
      fontSize: fontSize,
      fontFamily: FontNames.fontName,
      color: color,
      decorationColor: decorationColor,
      decoration: decoration,
      fontWeight: FontWeights.regular,
    );
  }

  /// Medium TextStyle = [FontWeight.w500]
  static TextStyle medium({
    double fontSize = 10,
    Color? color,
    Color? decorationColor,
    TextOverflow? textOverflow,
    TextDecoration decoration = TextDecoration.none,
    double? height,
  }) {
    return _getTextStyle(
      fontSize: fontSize,
      fontFamily: FontNames.fontName,
      decoration: decoration,
      decorationColor: decorationColor,
      color: color,
      textOverflow: textOverflow,
      fontWeight: FontWeights.medium,
      height: height,
    );
  }

  /// SemiBold TextStyle = FontWeight.w600
  static TextStyle semiBold(
      {double fontSize = 10,
      Color? color,
      Color? decorationColor,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
        fontSize: fontSize,
        fontFamily: FontNames.fontName,
        decoration: decoration,
        decorationColor: decorationColor,
        color: color,
        fontWeight: FontWeights.semiBold);
  }

  /// Bold TextStyle = [FontWeight.w700]
  static TextStyle bold(
      {double fontSize = 18,
      Color? color,
      Color? decorationColor,
      TextDecoration decoration = TextDecoration.none,
      TextOverflow textOverflow = TextOverflow.clip}) {
    return _getTextStyle(
      fontSize: fontSize,
      fontFamily: FontNames.fontName,
      decoration: decoration,
      decorationColor: decorationColor,
      color: color,
      textOverflow: textOverflow,
      fontWeight: FontWeights.bold,
    );
  }

  /// ExtraBold TextStyle = FontWeight.w800
  static TextStyle extraBold(
      {double fontSize = 10,
      Color? color,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
        fontSize: fontSize,
        fontFamily: FontNames.fontName,
        decoration: decoration,
        color: color,
        fontWeight: FontWeights.extraBold);
  }

  /// Black TextStyle = FontWeight.w900
  static TextStyle black(
      {double fontSize = 10,
      Color? color,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
        fontSize: fontSize,
        decoration: decoration,
        fontFamily: FontNames.fontName,
        color: color,
        fontWeight: FontWeights.black);
  }
}
