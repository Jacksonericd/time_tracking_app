import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/enums/bloc_states.dart';
import 'package:time_tracking_app/core/extentions/capitalize.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';

class BlocStateToWidget extends StatelessWidget {
  const BlocStateToWidget({
    Key? key,
    required this.blocStates,
    required this.child,
    required this.message,
  }) : super(key: key);
  final BlocStates blocStates;
  final Widget child;
  final String message;

  @override
  Widget build(BuildContext context) {
    return _stateToWidget(blocStates);
  }

  Widget _stateToWidget(BlocStates blocStates) {
    if (blocStates == BlocStates.loading) {
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
        ),
      );
    }

    if (blocStates == BlocStates.error) {
      return Center(
        child: StyledText.titleLarge(message.capitalize()),
      );
    }

    return child;
  }
}
