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
  });

  final Widget scaffoldBody;
  final String? appBarTitle;
  final bool hideAppBar;
  final AppBar? appBar;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hideAppBar
          ? null
          : appBar ??
              AppBar(
                elevation: 0,
                title: StyledText.titleSmall(appBarTitle ?? ''),
              ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation ??
          FloatingActionButtonLocation.centerDocked,
      body: scaffoldBody,
    );
  }
}
