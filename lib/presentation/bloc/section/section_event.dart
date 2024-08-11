part of 'section_bloc.dart';

abstract class SectionEvent {}

class GetSectionsEvent extends SectionEvent {
  final String projectId;

  GetSectionsEvent({required this.projectId});
}
