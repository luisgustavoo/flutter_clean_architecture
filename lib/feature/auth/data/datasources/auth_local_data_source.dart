import 'package:flutter_clean_architecture/core/constants.dart';
import 'package:flutter_clean_architecture/core/errors/cache_exception.dart';
import 'package:flutter_clean_architecture/core/errors/no_local_data_exception.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/entities/access_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  /// Get the cache [AccessToken]
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  bool isAuthenticated();

  /// Remove the cache [AccessToken]
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  void logout();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  bool isAuthenticated() {
    try {
      return sharedPreferences.getString(Constants.kAccessToken)?.isNotEmpty ??
          false;
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  void logout() {
    try {
      sharedPreferences.remove(Constants.kAccessToken);
    } on Exception catch (_) {
      throw CacheException();
    }
  }
}
