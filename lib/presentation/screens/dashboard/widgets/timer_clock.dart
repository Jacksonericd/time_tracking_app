import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/enums/task_type.dart';
import 'package:time_tracking_app/core/extentions/toTwoDigits.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';
import 'package:time_tracking_app/data/model/task_start_time.dart';
import 'package:time_tracking_app/domain/usecases/local_data_usecase.dart';

class TimerClock extends StatefulWidget {
  const TimerClock({
    super.key,
    required this.taskId,
    required this.taskType,
  });

  final String taskId;
  final TaskType taskType;

  @override
  State<StatefulWidget> createState() => TimerClockState();
}

class TimerClockState extends State<TimerClock> {
  Timer? _timer;
  String? _timerText;
  DateTime? _taskTimerStartedAt;

  @override
  void initState() {
    getTaskStartTimeStored();
    super.initState();
  }

  Future<void> getTaskStartTimeStored() async {
    try {
      if (widget.taskType == TaskType.todo) {
        return;
      }

      final localResponse =
          await Injector.resolve<LocalDataUseCase>().getTaskTimerById(
        widget.taskId,
      );

      final ongoingTasks = (localResponse as List)
          .map((task) => TasksStartTime.fromJson(task))
          .toList();

      _taskTimerStartedAt = DateTime.parse(ongoingTasks.last.startTime!);

      if (widget.taskType == TaskType.completed) {
        final _taskTimerEndedAt = DateTime.parse(ongoingTasks.last.endTime!);

        final durationInSeconds =
            _taskTimerEndedAt.difference(_taskTimerStartedAt!).inSeconds;

        _timerText = intToTimeLeft(durationInSeconds);

        setState(() {});

        return;
      }

      _startBackgroundTimerHandler();

      _startTimer();
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              if (_timerText != null) ...{
                StyledText.headlineLarge(_timerText!)
              },
              if (widget.taskType == TaskType.todo) ...{
                StyledText.titleSmall(
                    StringConstants.timerClockBeginTimerMessage),
              },
              if (widget.taskType == TaskType.ongoing) ...{
                StyledText.titleSmall(StringConstants.timeElapsed)
              },
              if (widget.taskType == TaskType.completed) ...{
                StyledText.titleSmall(StringConstants.timeSpent)
              },
            ],
          ),
        ));
  }

  void _endTimerIfActive() {
    if (_isTimerActive()) {
      _timer?.cancel();
    }
  }

  bool _isTimerActive() {
    if (_timer?.isActive ?? false) {
      return true;
    }

    return false;
  }

  void _startBackgroundTimerHandler() {
    SystemChannels.lifecycle.setMessageHandler((message) {
      if (message == AppLifecycleState.paused.toString()) {
        _clearTimerText();

        _endTimerIfActive();
      }

      if (message == AppLifecycleState.resumed.toString()) {}

      return Future(() => null);
    });
  }

  _clearTimerText() {
    _timerText = null;

    setState(() {});
  }

  Future<void> _startTimer() async {
    if (_taskTimerStartedAt == null) {
      return;
    }

    _endTimerIfActive();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final durationInSeconds =
          DateTime.now().difference(_taskTimerStartedAt!).inSeconds;

      _timerText = intToTimeLeft(durationInSeconds);
      setState(() {});
    });
  }

  String intToTimeLeft(int value) {
    int h, m, s;

    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);

    String result =
        "${h.toString().toTwoDigits()}:${m.toString().toTwoDigits()}:${s.toString().toTwoDigits()}";

    return result;
  }
}
