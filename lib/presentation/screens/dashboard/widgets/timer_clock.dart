import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';
import 'package:time_tracking_app/domain/usecases/local_data_usecase.dart';

class TimerClock extends StatefulWidget {
  const TimerClock({
    super.key,
    required this.taskId,
  });

  final String taskId;

  @override
  State<StatefulWidget> createState() => TimerClockState();
}

class TimerClockState extends State<TimerClock> {
  @override
  void initState() {
    getTaskStartTimeStored();
    super.initState();
  }

  Future<void> getTaskStartTimeStored() async {
    try {
      final localResponse =
          await Injector.resolve<LocalDataUseCase>().getTaskTimerById(
        widget.taskId,
      );
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        borderType: BorderType.Circle,
        color: ColorConstants.ongoingCount,
        dashPattern: const [2, 30],
        strokeWidth: 15,
        strokeCap: StrokeCap.round,
        child: SizedBox(
          height: 200,
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              StyledText.headlineLarge('00:00:00'),
              StyledText.titleMedium(StringConstants.timeElapsed)
            ],
          ),
        ));
  }
}
