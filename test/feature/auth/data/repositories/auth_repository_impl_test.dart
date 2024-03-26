import 'package:flutter_clean_architecture/core/errors/cache_exception.dart';
import 'package:flutter_clean_architecture/core/errors/failure.dart';
import 'package:flutter_clean_architecture/feature/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutter_clean_architecture/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_clean_architecture/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockAuthLocalDataSource mockAuthLocalDataSource;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockAuthRemoteDataSource,
      localDataSource: mockAuthLocalDataSource,
    );
  });

  group('isAuthenticated', () {
    test('should check if user is authenticated', () async {
      when(
        () => mockAuthLocalDataSource.isAuthenticated(),
      ).thenAnswer(
        (_) async => true,
      );

      final result = await repository.isAuthenticated();
      expect(result, true);
    });

    test('should check if user is unauthenticated', () async {
      when(
        () => mockAuthLocalDataSource.isAuthenticated(),
      ).thenAnswer(
        (_) async => false,
      );

      final result = await repository.isAuthenticated();
      expect(result, false);
    });

    test('should throw an exception CacheFailure', () async {
      when(
        () => mockAuthLocalDataSource.isAuthenticated(),
      ).thenThrow(
        CacheException(),
      );

      final call = repository.isAuthenticated;
      // expect(call(), throwsA(const TypeMatcher<NoLocalDataFailure>()));
      expect(call(), throwsA(isA<CacheFailure>()));
    });
  });
}
