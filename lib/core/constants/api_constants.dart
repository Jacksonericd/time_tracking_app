class ApiConstants {
  //Base Url of the API
  static const baseUrl = 'https://api.todoist.com/rest/v2';
  static const baseSyncUrl = 'https://api.todoist.com/sync/v9';

  //Task and Section API Path
  static const sectionsUrl = '$baseUrl/sections';
  static const tasksUrl = '$baseUrl/tasks';
  static const tasksCompleteUrl = '$baseSyncUrl/sync';
  static const tasksCompletedUrl = '$baseSyncUrl/completed/get_all';
  static const commentsUrl = '$baseUrl/comments';
}
