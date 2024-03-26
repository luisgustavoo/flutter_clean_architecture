import 'package:flutter_clean_architecture/core/errors/cache_exception.dart';
import 'package:flutter_clean_architecture/core/errors/failure.dart';
import 'package:flutter_clean_architecture/core/errors/server_exception.dart';
import 'package:flutter_clean_architecture/feature/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.localDataSource,
  });

  final AuthLocalDataSource localDataSource;

  @override
  bool isAuthenticated() {
    try {
      return localDataSource.isAuthenticated();
    } on CacheException catch (_) {
      throw CacheFailure();
    }
  }

  @override
  void logout() {
    try {
      localDataSource.logout();
    } on ServerException catch (_) {
      throw ServerFailure();
    }
  }
}
