import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.scaffoldBody,
    this.appBarTitle,
    this.hideAppBar = true,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.scaffoldBackgroundColor,
    this.bottomNavigationBar,
    this.drawer,
  });

  final Widget scaffoldBody;
  final String? appBarTitle;
  final bool hideAppBar;
  final AppBar? appBar;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? scaffoldBackgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hideAppBar
          ? null
          : appBar ??
              AppBar(
                backgroundColor: scaffoldBackgroundColor ??
                    Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                title: StyledText.titleSmall(appBarTitle ?? ''),
              ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation ??
          FloatingActionButtonLocation.centerDocked,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: drawer,
      body: scaffoldBody,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
