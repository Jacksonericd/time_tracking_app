import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';

class StyledText extends StatelessWidget {
  final String text;
  late final TextStyle? Function(BuildContext context)? getStyle;

  StyledText.displayLarge(this.text, {super.key}) {
    getStyle = (context) {
      final brightness = MediaQuery.of(context).platformBrightness;
      bool isDarkMode = brightness == Brightness.dark;

      return Theme.of(context).textTheme.displayLarge?.copyWith(
          color: isDarkMode
              ? ColorConstants.fontTitleDarkColor
              : ColorConstants.fontTitleLightColor);
    };
  }

  StyledText.displayMedium(this.text, {super.key}) {
    getStyle = (context) {
      final brightness = MediaQuery.of(context).platformBrightness;
      bool isDarkMode = brightness == Brightness.dark;

      return Theme.of(context).textTheme.displayMedium?.copyWith(
          color: isDarkMode
              ? ColorConstants.fontTitleDarkColor
              : ColorConstants.fontTitleDarkColor);
    };
  }

  StyledText.displaySmall(this.text, {super.key}) {
    getStyle = (context) {
      return Theme.of(context).textTheme.displaySmall;
    };
  }

  StyledText.bodyLarge(this.text, {super.key}) {
    getStyle = (context) {
      return Theme.of(context).textTheme.bodyLarge;
    };
  }

  StyledText.bodyMedium(this.text, {super.key}) {
    getStyle = (context) {
      return Theme.of(context).textTheme.bodyMedium;
    };
  }

  StyledText.bodySmall(this.text, {super.key}) {
    getStyle = (context) {
      return Theme.of(context).textTheme.bodySmall;
    };
  }

  StyledText.headlineLarge(this.text, {super.key}) {
    getStyle = (context) {
      return Theme.of(context).textTheme.headlineLarge?.copyWith();
    };
  }

  StyledText.headlineMedium(this.text, {super.key}) {
    getStyle = (context) {
      return Theme.of(context).textTheme.headlineMedium;
    };
  }

  StyledText.headlineSmall(this.text, {super.key}) {
    getStyle = (context) {
      final brightness = MediaQuery.of(context).platformBrightness;
      bool isDarkMode = brightness == Brightness.dark;

      return Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: isDarkMode
              ? ColorConstants.fontTitleDarkColor
              : ColorConstants.fontTitleLightColor);
    };
  }

  StyledText.titleLarge(this.text, {super.key}) {
    getStyle = (context) {
      return Theme.of(context).textTheme.titleLarge;
    };
  }

  StyledText.titleMedium(this.text, {super.key}) {
    getStyle = (context) {
      return Theme.of(context).textTheme.titleMedium;
    };
  }

  StyledText.titleSmall(this.text, {super.key}) {
    getStyle = (context) {
      return Theme.of(context).textTheme.titleSmall;
    };
  }

  StyledText.labelLarge(this.text, {super.key}) {
    getStyle = (context) {
      return Theme.of(context).textTheme.labelLarge?.copyWith(
            overflow: TextOverflow.ellipsis,
            color: ColorConstants.colorWhite,
          );
      ;
    };
  }

  StyledText.labelMedium(this.text, {super.key}) {
    getStyle = (context) {
      return Theme.of(context).textTheme.labelMedium?.copyWith(
            overflow: TextOverflow.ellipsis,
            color: ColorConstants.colorWhite,
          );
    };
  }

  StyledText.labelSmall(this.text, {super.key}) {
    getStyle = (context) {
      return Theme.of(context)
          .textTheme
          .labelSmall
          ?.copyWith(overflow: TextOverflow.ellipsis);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, style: getStyle?.call(context));
  }
}
