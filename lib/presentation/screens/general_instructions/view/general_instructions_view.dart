import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_scaffold.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';

import '../widgets/instruction_card.dart';

class GeneralInstructionsView extends StatelessWidget {
  const GeneralInstructionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        hideAppBar: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: StyledText.titleMedium(StringConstants.generalInstructions),
        ),
        scaffoldBody: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
                children: StringConstants.generalInstructionAll
                    .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                      child: InstructionCard(
                            instructionHeading: e['heading'],
                            instructionText: e['detail'],
                          ),
                    ))
                    .toList()),
          ),
        ));
  }
}
