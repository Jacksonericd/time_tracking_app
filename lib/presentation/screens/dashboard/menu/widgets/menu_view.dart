import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:time_tracking_app/core/constants/route_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';
import 'package:time_tracking_app/core/presentation/widgets/widget_tap.dart';
import 'package:time_tracking_app/presentation/bloc/theme/theme_cubit.dart';

import 'menu_item_button.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<StatefulWidget> createState() => MenuViewState();
}

class MenuViewState extends State<MenuView> {
  Widget get vSpacing50 => const SizedBox(
        height: 50,
      );

  Widget get vSpacingTen => const SizedBox(
        height: 10,
      );

  Widget get _backButton => const Icon(Icons.arrow_back_outlined);

  @override
  Widget build(BuildContext context) {
    final currentThemeMode = context.read<ThemeCubit>().getCurrentThemeMode();

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
            onMenuItemClicked: () => Navigator.of(context)
                .pushNamed(RouteConstants.generalInstructions),
            menuItemIcon: Icons.info,
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
          MenuItem(
            menuItemText: StringConstants.darkMode,
            onMenuItemClicked: () {},
            menuItemIcon: Icons.dark_mode_rounded,
            rightSideWidget: Switch(
              value: currentThemeMode == StringConstants.dark,
              onChanged: (bool value) {
                context.read<ThemeCubit>().setThemeMode(
                    value ? StringConstants.dark : StringConstants.light);

                setState(() {});
              },
            ),
          ),
          vSpacingTen,
          vSpacingTen,
        ],
      ),
    );
  }
}
