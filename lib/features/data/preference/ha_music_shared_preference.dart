abstract class HaMusicSharedPreference {
  Future<void> put<T>(String key, T value);

  T? get<T>(String key);

  Future<void> removeKey(String key);
}
