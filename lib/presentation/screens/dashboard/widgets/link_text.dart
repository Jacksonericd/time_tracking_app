import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/presentation/widgets/widget_tap.dart';

class LinkText extends StatelessWidget {
  const LinkText({
    super.key,
    required this.linkDisplayText,
    this.color,
    required this.onTap,
  });

  final String linkDisplayText;
  final Color? color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return WidgetTap(
      widget: Text(linkDisplayText,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                decoration: TextDecoration.underline,
                color: color ?? Theme.of(context).shadowColor,
                decorationColor: color ?? Theme.of(context).shadowColor,
                decorationThickness: 1,
              )
          // ?.copyWith(color: ColorConstants.errorRed),
          ),
      onWidgetTap: onTap,
    );
  }
}
