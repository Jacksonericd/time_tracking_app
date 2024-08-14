import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CommonFunctions {
  static String formatToRFC3339NanoUtc(DateTime date) {
    return DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSSSSS+00:00")
        .format(DateTime.parse(date.toString()).toUtc());
  }
}
