import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/constants/route_constants.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_scaffold.dart';
import 'package:time_tracking_app/core/presentation/widgets/bloc_state_widget.dart';
import 'package:time_tracking_app/data/model/sections.dart';
import 'package:time_tracking_app/presentation/bloc/section/section_bloc.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SectionBloc()
        ..add(GetSectionsEvent(
          projectId: '2337659677',
        )),
      child: AppScaffold(
        hideAppBar: false,
        appBar: AppBar(
          title: Text('Sections'),
        ),
        scaffoldBody: BlocBuilder<SectionBloc, SectionState>(
          builder: (context, state) {
            return BlocStateToWidget(
              message: state.message ?? '',
              blocStates: state.blocStates,
              child: displaySectionsData(
                state.sections,
                context,
              ),
            );
          },
        ),
      ),
    );
  }

  displaySectionsData(List<Sections>? sections, BuildContext context) {
    if ((sections ?? []).isEmpty) {
      return const Text('No sections found');
    }

    final deviceWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
        itemCount: sections!.length,
        itemBuilder: (context, index) {
          final section = sections[index];

          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(RouteConstants.taskListPath,
                  arguments: section.id);
            },
            child: Container(
              width: deviceWidth * 0.9,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
              child: Text(section.name!),
            ),
          );
        });
  }
}
