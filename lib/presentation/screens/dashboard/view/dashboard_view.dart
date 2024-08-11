import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_scaffold.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      scaffoldBody: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Dashboard'),
        ],
      ),
    );
  }

}