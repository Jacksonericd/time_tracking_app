import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_tracking_app/core/services/shared_preference_service/preference_service.dart';

class AppPreferencesService extends PreferenceService {
  AppPreferencesService() {
    _initialize();
  }

  late final SharedPreferences prefs;

  Future<void> _initialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<String?> getString(String key) async {
    if (prefs.containsKey(key)) {
      prefs.getString(key);
    }
    return null;
  }

  @override
  Future<void> storeString(String key, String value) async {
    await prefs.setString(key, value);
  }
}
