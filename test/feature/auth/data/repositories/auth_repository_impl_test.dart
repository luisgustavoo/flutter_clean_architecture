import 'package:flutter_clean_architecture/core/errors/cache_exception.dart';
import 'package:flutter_clean_architecture/core/errors/failure.dart';
import 'package:flutter_clean_architecture/feature/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutter_clean_architecture/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthLocalDataSource mockAuthLocalDataSource;

  setUp(() {
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(
      localDataSource: mockAuthLocalDataSource,
    );
  });

  group('isAuthenticated', () {
    test('should check if user is authenticated', () {
      when(
        () => mockAuthLocalDataSource.isAuthenticated(),
      ).thenReturn(true);

      expect(repository.isAuthenticated(), true);
    });

    test('should check if user is unauthenticated', () {
      when(
        () => mockAuthLocalDataSource.isAuthenticated(),
      ).thenReturn(false);

      expect(repository.isAuthenticated(), false);
    });

    test('should throw an exception CacheFailure', () {
      when(
        () => mockAuthLocalDataSource.isAuthenticated(),
      ).thenThrow(
        CacheException(),
      );

      // expect(call(), throwsA(const TypeMatcher<NoLocalDataFailure>()));
      expect(() => repository.isAuthenticated(), throwsA(isA<CacheFailure>()));
    });
  });
}
