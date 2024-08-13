import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';

class CustomThemeData {
  static ThemeData lightTheme = ThemeData(
    fontFamily: StringConstants.fontFamily,
    primaryColorDark: ColorConstants.colorBlack,
    primaryColorLight: ColorConstants.colorWhite,
    scaffoldBackgroundColor: ColorConstants.lightScaffoldBackgroundColor,
    cardColor: ColorConstants.cardLightColor,
    hintColor: ColorConstants.hintColorLight,
    focusColor: ColorConstants.focusColorLight,
    dividerColor: ColorConstants.lighterGrey,
    disabledColor: ColorConstants.transparent,
    hoverColor: ColorConstants.lightGrey,
    indicatorColor: ColorConstants.lighterGrey,
    canvasColor: ColorConstants.buttonBackgroundColor,
    highlightColor: ColorConstants.successGreen,
    colorScheme: const ColorScheme.light(
      primary: ColorConstants.primaryColor,
      secondary: ColorConstants.secondaryColor,
      primaryContainer: ColorConstants.cardLightColor,
      error: ColorConstants.errorRed,
      tertiary: ColorConstants.selectionRedColor,
      shadow: ColorConstants.shadowColor,
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColorDark: ColorConstants.colorWhite,
    primaryColorLight: ColorConstants.lighterGrey,
    scaffoldBackgroundColor: ColorConstants.darkScaffoldBackgroundColor,
    cardColor: ColorConstants.cardDarkColor,
    hintColor: ColorConstants.hintColorDark,
    focusColor: ColorConstants.focusColorDark,
    dividerColor: ColorConstants.lighterGrey,
    disabledColor: ColorConstants.transparent,
    unselectedWidgetColor: Colors.grey,
    colorScheme: const ColorScheme.dark(
      primary: ColorConstants.primaryColor,
      secondary: ColorConstants.secondaryColor,
      primaryContainer: ColorConstants.cardDarkColor,
      tertiary: ColorConstants.selectionRedColor,
      tertiaryContainer: ColorConstants.colorWhite,
      error: ColorConstants.errorRed,
      shadow: ColorConstants.shadowColor,
    ),
  );
}
