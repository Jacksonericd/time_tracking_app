import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';

class CustomThemeData {
  static ThemeData lightTheme = ThemeData(
    fontFamily: StringConstants.fontFamily,
    primaryColorDark: ColorConstants.colorBlack,
    primaryColorLight: ColorConstants.colorWhite,
    scaffoldBackgroundColor: ColorConstants.lightScaffoldBackgroundColor,
    cardColor: ColorConstants.cardColor,
    dividerColor: ColorConstants.lighterGrey,
    disabledColor: ColorConstants.transparent,
    focusColor: ColorConstants.borderGrey,
    hintColor: ColorConstants.fontGrey,
    hoverColor: ColorConstants.lightGrey,
    indicatorColor: ColorConstants.lighterGrey,
    canvasColor: ColorConstants.buttonBackgroundColor,
    highlightColor: ColorConstants.successGreen,
    buttonTheme: const ButtonThemeData(
        buttonColor: ColorConstants.buttonBackgroundColor),
    colorScheme: const ColorScheme.light(
      primary: ColorConstants.primaryColor,
      secondary: ColorConstants.secondaryColor,
      primaryContainer: ColorConstants.containerColorLight,
      error: ColorConstants.errorRed,
      tertiary: ColorConstants.selectionRedColor,
      shadow: ColorConstants.shadowColor,
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColorDark: ColorConstants.colorWhite,
    primaryColorLight: ColorConstants.lighterGrey,
    unselectedWidgetColor: Colors.grey,
    colorScheme: const ColorScheme.dark(
      primary: ColorConstants.primaryColor,
      secondary: ColorConstants.secondaryColor,
      primaryContainer: ColorConstants.colorWhite,
      tertiary: ColorConstants.selectionRedColor,
      tertiaryContainer: ColorConstants.colorWhite,
      error: ColorConstants.errorRed,
      shadow: ColorConstants.shadowColor,
    ),
    cardColor: ColorConstants.containerColorDark,
    dividerColor: ColorConstants.lighterGrey,
  );
}
