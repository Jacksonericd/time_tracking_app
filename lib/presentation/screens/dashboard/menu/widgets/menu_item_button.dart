import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/presentation/widgets/widget_tap.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.menuItemText,
    required this.onMenuItemClicked,
    required this.menuItemIcon,
    this.rightSideWidget,
  });

  final String menuItemText;
  final IconData menuItemIcon;
  final VoidCallback onMenuItemClicked;
  final Widget? rightSideWidget;

  @override
  Widget build(BuildContext context) {
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
              rightSideWidget ??
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
