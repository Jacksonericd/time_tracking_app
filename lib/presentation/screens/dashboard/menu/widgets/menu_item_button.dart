import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';
import 'package:time_tracking_app/core/presentation/widgets/widget_tap.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.menuItemText,
    required this.onMenuItemClicked,
    required this.menuItemIcon,
  });

  final String menuItemText;
  final IconData menuItemIcon;
  final VoidCallback onMenuItemClicked;

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return WidgetTap(
        widget: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    menuItemIcon,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    menuItemText,
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
              const Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 25,
              )
            ],
          ),
        ),
        onWidgetTap: onMenuItemClicked);
  }
}
