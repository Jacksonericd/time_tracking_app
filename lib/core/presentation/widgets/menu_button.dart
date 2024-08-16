import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';
import 'package:time_tracking_app/core/presentation/widgets/widget_tap.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.onMenuTapped,
    required this.menuText,
  });

  final String menuText;
  final VoidCallback onMenuTapped;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return WidgetTap(
      onWidgetTap: onMenuTapped,
      widget: Container(
        height: 40,
        width: deviceWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: const [
                0.1,
                0.7
              ],
              colors: [
                ColorConstants.buttonGradient.withOpacity(0.5),
                ColorConstants.buttonGradient,
              ]),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 0.5,
              blurRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: StyledText.labelMedium(menuText),
      ),
    );
  }
}
