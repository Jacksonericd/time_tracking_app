import 'package:time_tracking_app/data/datasources/remote/section_remote_datasource.dart';
import 'package:time_tracking_app/domain/repo_abstract/section_abstract.dart';

class SectionRepo extends SectionAbstract {
  final SectionRemoteDataSource sectionRemoteDataSource;

  SectionRepo({
    required this.sectionRemoteDataSource,
  });

  @override
  Future fetchAllSections({required String projectId}) {
    return sectionRemoteDataSource.fetchAllSections(projectId: projectId);
  }
}
