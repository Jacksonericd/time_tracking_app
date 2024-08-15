import 'package:time_tracking_app/core/constants/string_constants.dart';

class CustomBlocValidators {
  static String? requiredTaskContent(dynamic value) {
    if (value == null ||
        value == false ||
        ((value is Iterable || value is String || value is Map) &&
            value.length == 0)) {
      return StringConstants.taskContentRequired;
    }
    return null;
  }

  static String? requiredTaskDescription(dynamic value) {
    if (value == null ||
        value == false ||
        ((value is Iterable || value is String || value is Map) &&
            value.length == 0)) {
      return StringConstants.taskDescriptionRequired;
    }
    return null;
  }

  static String? requiredPriority(dynamic value) {
    if (value == null ||
        value == false ||
        ((value is Iterable || value is String || value is Map) &&
            value.length == 0)) {
      return StringConstants.selectPriority;
    }
    return null;
  }

  static String? requiredCommentContent(dynamic value) {
    if (value == null ||
        value == false ||
        ((value is Iterable || value is String || value is Map) &&
            value.length == 0)) {
      return StringConstants.commentContentRequired;
    }
    return null;
  }
}
