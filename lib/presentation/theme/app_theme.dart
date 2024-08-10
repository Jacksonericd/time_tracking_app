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
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: ColorConstants.fontBlackColor,
        fontSize: 36, //57
        fontWeight: FontWeight.w600,
      ),
      displayMedium: TextStyle(
          color: ColorConstants.fontBlackColor,
          fontSize: 34, //45
          fontWeight: FontWeight.w600),
      displaySmall: TextStyle(
          color: ColorConstants.fontBlackColor,
          fontSize: 32,
          fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(
          color: ColorConstants.fontBlackColor,
          fontSize: 30,
          fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(
          color: ColorConstants.fontBlackColor,
          fontSize: 28,
          fontWeight: FontWeight.w600),
      bodySmall: TextStyle(
          color: ColorConstants.fontBlackColor,
          fontSize: 26,
          fontWeight: FontWeight.w600),
      headlineLarge: TextStyle(
          color: ColorConstants.fontBlackColor,
          fontSize: 24,
          fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(
          color: ColorConstants.fontBlackColor,
          fontSize: 22,
          fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(
          color: ColorConstants.fontBlackColor,
          fontSize: 20,
          fontWeight: FontWeight.w600),
      titleLarge: TextStyle(
          color: ColorConstants.fontBlackColor,
          fontSize: 18, //22
          fontWeight: FontWeight.w600),
      titleMedium: TextStyle(
          color: ColorConstants.fontGreyColor,
          fontSize: 16, //16
          fontWeight: FontWeight.w600),
      titleSmall: TextStyle(
          color: ColorConstants.fontBlackColor,
          fontSize: 14, //14
          fontWeight: FontWeight.w600),
      labelLarge: TextStyle(
          color: ColorConstants.fontBlackColor,
          fontSize: 12,
          fontWeight: FontWeight.w600),
      labelMedium: TextStyle(
          color: ColorConstants.fontBlackColor,
          fontSize: 10,
          fontWeight: FontWeight.w600),
      labelSmall: TextStyle(
          color: ColorConstants.fontBlackColor,
          fontSize: 8,
          fontWeight: FontWeight.w600),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        )),
        backgroundColor:
            MaterialStateProperty.all(ColorConstants.buttonBackgroundColor),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: ColorConstants.primaryColor,
      unselectedItemColor: ColorConstants.lightGrey,
      backgroundColor: ColorConstants.colorWhite,
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
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: ColorConstants.colorWhite,
        fontSize: 36, //57
        fontWeight: FontWeight.w600,
      ),
      displayMedium: TextStyle(
          color: ColorConstants.colorWhite,
          fontSize: 34, //45
          fontWeight: FontWeight.w600),
      displaySmall: TextStyle(
          color: ColorConstants.colorWhite,
          fontSize: 32,
          fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(
          color: ColorConstants.colorWhite,
          fontSize: 30,
          fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(
          color: ColorConstants.colorWhite,
          fontSize: 28,
          fontWeight: FontWeight.w600),
      bodySmall: TextStyle(
          color: ColorConstants.colorWhite,
          fontSize: 26,
          fontWeight: FontWeight.w600),
      headlineLarge: TextStyle(
          color: ColorConstants.colorWhite,
          fontSize: 24,
          fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(
          color: ColorConstants.colorWhite,
          fontSize: 22,
          fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(
          color: ColorConstants.colorWhite,
          fontSize: 20,
          fontWeight: FontWeight.w600),
      titleLarge: TextStyle(
          color: ColorConstants.colorWhite,
          fontSize: 18, //22
          fontWeight: FontWeight.w600),
      titleMedium: TextStyle(
          color: ColorConstants.colorWhite,
          fontSize: 16, //16
          fontWeight: FontWeight.w600),
      titleSmall: TextStyle(
          color: ColorConstants.colorWhite,
          fontSize: 14, //14
          fontWeight: FontWeight.w600),
      labelLarge: TextStyle(
          color: ColorConstants.colorWhite,
          fontSize: 12,
          fontWeight: FontWeight.w600),
      labelMedium: TextStyle(
          color: ColorConstants.colorWhite,
          fontSize: 10,
          fontWeight: FontWeight.w600),
      labelSmall: TextStyle(
          color: ColorConstants.colorWhite,
          fontSize: 8,
          fontWeight: FontWeight.w600),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        )),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: ColorConstants.primaryColor,
      unselectedItemColor: ColorConstants.lightGrey,
      backgroundColor: ColorConstants.colorWhite,
    ),
  );
}
