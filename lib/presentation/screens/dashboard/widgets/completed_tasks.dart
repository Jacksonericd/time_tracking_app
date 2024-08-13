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

    const cardColor = ColorConstants.completedCard;

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
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: cardColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StyledText.titleMedium(task.content!),
                      const Icon(Icons.info),
                    ],
                  ),
                  const Divider(),
                  if (task.completedAt != null) ...{
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(Icons.date_range),
                        StyledText.labelLarge(' ${task.completedAt}'),
                      ],
                    )
                  },
                ],
              ),
            );
          });
    }

    return Container(
      height: 150,
      width: deviceWidth,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TaskHeading(
            headingText: StringConstants.completed,
            cardColor: cardColor,
          ),
          const SizedBox(
            height: 5,
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
