import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String text;
  late final TextStyle? Function(BuildContext context)? getStyle;

  StyledText.displayLarge(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return Theme.of(context).textTheme.displayLarge;
    };
  }

  StyledText.displayMedium(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return Theme.of(context).textTheme.displayMedium;
    };
  }

  StyledText.displaySmall(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return Theme.of(context).textTheme.displaySmall;
    };
  }

  StyledText.bodyLarge(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return Theme.of(context).textTheme.bodyLarge;
    };
  }

  StyledText.bodyMedium(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return Theme.of(context).textTheme.bodyMedium;
    };
  }

  StyledText.bodySmall(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return Theme.of(context).textTheme.bodySmall;
    };
  }

  StyledText.headlineLarge(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return Theme.of(context).textTheme.headlineLarge;
    };
  }

  StyledText.headlineMedium(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return Theme.of(context).textTheme.headlineMedium;
    };
  }

  StyledText.headlineSmall(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return Theme.of(context).textTheme.headlineSmall;
    };
  }

  StyledText.titleLarge(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return Theme.of(context).textTheme.titleLarge;
    };
  }

  StyledText.titleMedium(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return Theme.of(context).textTheme.titleMedium;
    };
  }

  StyledText.titleSmall(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return Theme.of(context).textTheme.titleSmall;
    };
  }

  StyledText.labelLarge(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return Theme.of(context).textTheme.labelLarge;
    };
  }

  StyledText.labelMedium(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return Theme.of(context).textTheme.labelMedium;
    };
  }

  StyledText.labelSmall(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return Theme.of(context).textTheme.labelSmall;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, style: getStyle?.call(context));
  }
}
