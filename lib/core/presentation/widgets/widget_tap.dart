import 'package:flutter/material.dart';

class WidgetTap extends StatelessWidget {
  const WidgetTap({
    super.key,
    required this.widget,
    required this.onWidgetTap,
  });

  final Widget widget;
  final VoidCallback onWidgetTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onWidgetTap,
      child: widget,
    );
  }
}
