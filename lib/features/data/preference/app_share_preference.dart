import 'package:music_app/features/data/preference/ha_music_shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharePreference extends HaMusicSharedPreference {
  final SharedPreferences mPrefs;

  AppSharePreference(this.mPrefs);

  @override
  T? get<T>(String key) {
    switch (T) {
      case String:
        return mPrefs.getString(key) as T?;
      default:
        return null;
    }
  }

  @override
  Future<void> put<T>(String key, T? value) async {
    switch (value.runtimeType) {
      case String:
        await mPrefs.setString(key, value as String);
      case bool:
        await mPrefs.setBool(key, value as bool);
      default:
        {}
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final isRemove = await mPrefs.remove(key);
    return isRemove;
  }
}
