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

  void mockReturnLocalDataSource({
    bool? mockReturn,
    bool isException = false,
  }) {
    switch (isException) {
      case true:
        when(
          () => mockAuthLocalDataSource.isAuthenticated(),
        ).thenThrow(
          CacheException(),
        );
      default:
        when(
          () => mockAuthLocalDataSource.isAuthenticated(),
        ).thenReturn(
          mockReturn ?? false,
        );
    }
  }

  group('isAuthenticated', () {
    test('Should check if user is authenticated', () {
      mockReturnLocalDataSource(mockReturn: true);

      expect(repository.isAuthenticated(), true);
    });

    test('Should check if user is unauthenticated', () {
      mockReturnLocalDataSource(mockReturn: false);

      expect(repository.isAuthenticated(), false);
    });

    test('Should throw an exception CacheFailure', () {
      mockReturnLocalDataSource(isException: true);

      // expect(call(), throwsA(const TypeMatcher<NoLocalDataFailure>()));
      expect(() => repository.isAuthenticated(), throwsA(isA<CacheFailure>()));
    });
  });
}
