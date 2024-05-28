import 'package:get_it/get_it.dart';
import 'package:music_app/features/data/preference/app_share_preference.dart';
import 'package:music_app/features/data/preference/ha_music_shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDi {
  SharedPreferencesDi._();

  static Future<void> init(GetIt injector) async {
    injector.registerSingletonAsync<HaMusicSharedPreference>(() async {
      SharedPreferences mPrefs = await SharedPreferences.getInstance();
      return AppSharePreference(mPrefs);
    });
  }
}
