import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';

class CustomThemeData {
  static ThemeData lightTheme = ThemeData(
    fontFamily: StringConstants.fontFamily,
    primaryColorDark: ColorConstants.colorBlack,
    primaryColorLight: ColorConstants.colorWhite,
    scaffoldBackgroundColor: ColorConstants.lightScaffoldBackgroundColor,
    cardColor: ColorConstants.lightScaffoldBackgroundColor,
    hintColor: ColorConstants.hintColorLight,
    focusColor: ColorConstants.focusColorLight,
    dividerColor: ColorConstants.lighterGrey,
    disabledColor: ColorConstants.transparent,
    hoverColor: ColorConstants.lightGrey,
    indicatorColor: ColorConstants.lighterGrey,
    canvasColor: ColorConstants.buttonBackgroundColor,
    highlightColor: ColorConstants.successGreen,
    shadowColor: ColorConstants.greyColorC3,
    colorScheme: const ColorScheme.light(
      primary: ColorConstants.primaryColor,
      secondary: ColorConstants.secondaryColor,
      primaryContainer: ColorConstants.colorWhite,
      error: ColorConstants.errorRed,
      tertiary: ColorConstants.lightScaffoldBackgroundColor,
      shadow: ColorConstants.shadowColor,
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColorDark: ColorConstants.colorWhite,
    primaryColorLight: ColorConstants.colorBlack,
    scaffoldBackgroundColor: ColorConstants.darkScaffoldBackgroundColor,
    cardColor: ColorConstants.darkPrimaryContainerColor,
    hintColor: ColorConstants.hintColorDark,
    focusColor: ColorConstants.colorBlack,
    dividerColor: ColorConstants.lighterGrey,
    disabledColor: ColorConstants.transparent,
    shadowColor: ColorConstants.greyColorC3,
    unselectedWidgetColor: Colors.grey,
    colorScheme: const ColorScheme.dark(
      primary: ColorConstants.primaryColor,
      secondary: ColorConstants.secondaryColor,
      primaryContainer: ColorConstants.darkPrimaryContainerColor,
      tertiary: ColorConstants.colorWhite,
      tertiaryContainer: ColorConstants.colorWhite,
      error: ColorConstants.errorRed,
      shadow: ColorConstants.shadowColor,
    ),
  );
}
