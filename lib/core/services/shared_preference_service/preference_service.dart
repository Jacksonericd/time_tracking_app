abstract class PreferenceService {
  Future<void> storeString(String key, String value);

  Future<String?> getString(String key);
}
