import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/constants/route_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/presentation/widgets/menu_button.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';
import 'package:time_tracking_app/core/presentation/widgets/widget_tap.dart';

import 'menu_item_button.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  Widget get vSpacing50 => const SizedBox(
        height: 50,
      );

  Widget get vSpacingTen => const SizedBox(
        height: 10,
      );

  Widget get _backButton => const Icon(Icons.arrow_back_outlined);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          vSpacing50,
          WidgetTap(
            widget: _backButton,
            onWidgetTap: () => Navigator.of(context)
                .pushReplacementNamed(RouteConstants.dashboardPath),
          ),
          vSpacingTen,
          vSpacingTen,
          StyledText.headlineMedium(StringConstants.menu),
          vSpacingTen,
          vSpacingTen,
          vSpacingTen,
          MenuItem(
            menuItemText: StringConstants.generalInstructions,
            onMenuItemClicked: () =>
                Navigator.of(context).pushNamed(RouteConstants.generalInstructions),
            menuItemIcon: Icons.info,
          ),
          vSpacingTen,
          vSpacingTen,
          MenuItem(
            menuItemText: StringConstants.changeThemMode,
            onMenuItemClicked: () {},
            menuItemIcon: Icons.dark_mode_rounded,
          ),
          vSpacingTen,
          vSpacingTen,
          MenuItem(
            menuItemText: StringConstants.addNewTask,
            onMenuItemClicked: () =>
                Navigator.of(context).pushNamed(RouteConstants.addTaskPath),
            menuItemIcon: Icons.add_box_rounded,
          ),
          vSpacingTen,
          vSpacingTen,
        ],
      ),
    );
  }
}
