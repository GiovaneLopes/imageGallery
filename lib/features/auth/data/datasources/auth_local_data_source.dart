import 'package:meta/meta.dart';
import 'package:imageGallery/core/error/exception.dart';
import 'package:imageGallery/core/resources/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUserToken(String token);
  Future<void> cleanCache();
  Future<String> getUserToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheUserToken(String token) {
    return sharedPreferences.setString(Keys.CACHED_USER_TOKEN, token);
  }

  @override
  Future<void> cleanCache() async {
    bool isCleared = await sharedPreferences.clear();
    if (!isCleared) {
      throw CacheException();
    }
  }

  @override
  Future<String> getUserToken() async {
    try {
      return sharedPreferences.getString(Keys.CACHED_USER_TOKEN);
    } catch (e) {
      print("[SplashLocalDataSourceImpl] ${e.toString()}");
      throw CacheException();
    }
  }
}
