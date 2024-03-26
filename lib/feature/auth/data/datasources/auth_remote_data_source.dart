import 'package:flutter_clean_architecture/core/errors/server_exception.dart';

abstract class AuthRemoteDataSource {
  /// Call the http://baseurl:8080/auth/logout endpoint
  ///
  /// Throws a [ServerException] for all error codes
  Future<void> logout();
}
