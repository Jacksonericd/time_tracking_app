import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';
import 'package:time_tracking_app/data/model/completed_items.dart';
import 'package:time_tracking_app/presentation/screens/dashboard/widgets/task_heading.dart';

class CompletedTasks extends StatelessWidget {
  const CompletedTasks({
    super.key,
    this.tasks,
  });

  final List<CompletedItem>? tasks;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    // const cardColor = ColorConstants.completedCard;
    final cardColor = Theme.of(context).primaryColorLight;
    final dividerColor = Theme.of(context).primaryColorDark.withOpacity(0.10);

    Widget dataWidget = noTasksAvailable;

    if ((tasks ?? []).isNotEmpty) {
      dataWidget = ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tasks!.length,
          itemBuilder: (context, index) {
            final task = tasks![index];

            return Container(
              width:
                  tasks!.length == 1 ? deviceWidth * 0.9 : deviceWidth * 0.75,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: cardColor,
                boxShadow: const [
                  BoxShadow(
                    color: ColorConstants.greyColorC3,
                    spreadRadius: 0.5,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StyledText.titleMedium(task.content!),
                  StyledText.labelSmall(' ${task.completedAt}')
                ],
              ),
            );
          });
    }

    return SizedBox(
      height: 120,
      width: deviceWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TaskHeading(
            headingText: StringConstants.completed,
            cardColor: cardColor,
          ),
          Expanded(child: dataWidget),
        ],
      ),
    );
  }
}

Widget get noTasksAvailable => Center(
      child: StyledText.headlineSmall(
        StringConstants.noTasksAvailable,
      ),
    );
