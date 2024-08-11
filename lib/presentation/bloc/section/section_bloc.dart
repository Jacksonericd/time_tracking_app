import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/enums/bloc_states.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/data/model/sections.dart';
import 'package:time_tracking_app/domain/usecases/section_usecase.dart';

part 'section_event.dart';

part 'section_state.dart';

class SectionBloc extends Bloc<SectionEvent, SectionState> {
  SectionBloc() : super(SectionsLoadingState()) {
    on<SectionEvent>(_init);
  }

  void _init(SectionEvent event, Emitter<SectionState> emit) async {
    emit(SectionsLoadingState());

    if (event is GetSectionsEvent) {
      try {
        dynamic response =
            await Injector.resolve<SectionUseCase>().fetchAllSections(
          projectId: event.projectId,
        );

        final sections = Sections.fromJson(response);

        emit(SectionsLoadedState(
          sectionsList: [sections],
        ));
      } catch (e) {
        if (e is DioException) {
          emit(SectionsErrorState(error: '${e.error}'));
          return;
        }
        emit(SectionsErrorState(error: '$e'));
      }
    }
  }
}
