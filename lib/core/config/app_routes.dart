import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:time_tracking_app/core/constants/route_constants.dart';
import 'package:time_tracking_app/presentation/screens/comments/view/add_edit_comment.dart';
import 'package:time_tracking_app/presentation/screens/dashboard/view/dashboard_tab_view.dart';
import 'package:time_tracking_app/presentation/screens/general_instructions/view/general_instructions_view.dart';
import 'package:time_tracking_app/presentation/screens/offline/view/offline_view.dart';
import 'package:time_tracking_app/presentation/screens/splash_screen/view/splash_view.dart';
import 'package:time_tracking_app/presentation/screens/tasks/view/add_edit_task.dart';

class AppRoutes {
  Route generateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      builder: (_) => OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivityResult, Widget child) {
          final bool connected = connectivityResult != ConnectivityResult.none;
          if (!connected) {
            return const OfflineView();
          }
          return displayView(routeSettings);
        },
        child: const SizedBox.shrink(),
      ),
      settings: routeSettings,
    );
  }

  Widget displayView(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case RouteConstants.splashPath:
        return const SplashView();
      case RouteConstants.dashboardPath:
        return const DashboardTabView();
      case RouteConstants.addTaskPath:
        return const AddEditTask();
      case RouteConstants.editTaskPath:
        final props = args as Map;
        return AddEditTask(
          isEditMode: true,
          taskId: props['task-id'],
        );
      case RouteConstants.addCommentPath:
        final props = args as Map;
        return AddEditComment(
          taskId: props['task-id'],
        );
      case RouteConstants.editCommentPath:
        final props = args as Map;
        return AddEditComment(
          isEditMode: true,
          commentId: props['comment-id'],
        );
      case RouteConstants.generalInstructions:
        return const GeneralInstructionsView();
      default:
        return const SplashView();
    }
  }
}
