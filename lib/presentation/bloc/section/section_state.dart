part of 'section_bloc.dart';

abstract class SectionState {
  final BlocStates blocStates;
  final String? message;
  final List<Sections>? sections;

  SectionState({
    required this.blocStates,
    this.message,
    this.sections,
  });
}

class SectionsLoadingState extends SectionState {
  SectionsLoadingState() : super(blocStates: BlocStates.loading);
}

class SectionsLoadedState extends SectionState {
  final List<Sections>? sectionsList;

  SectionsLoadedState({required this.sectionsList})
      : super(
          blocStates: BlocStates.loaded,
          sections: sectionsList,
        );
}

class SectionsErrorState extends SectionState {
  final String error;

  SectionsErrorState({required this.error})
      : super(
          blocStates: BlocStates.error,
          message: error,
        );
}
