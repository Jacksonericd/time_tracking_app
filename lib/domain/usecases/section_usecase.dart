import '../repo_abstract/section_abstract.dart';

class SectionUseCase {
  final SectionAbstract sectionAbstract;

  SectionUseCase(this.sectionAbstract);

  Future<dynamic> fetchAllSections({required String projectId}) =>
      sectionAbstract.fetchAllSections(projectId: projectId);
}
