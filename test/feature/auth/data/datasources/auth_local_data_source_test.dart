import 'package:flutter_clean_architecture/core/constants.dart';
import 'package:flutter_clean_architecture/core/errors/cache_exception.dart';
import 'package:flutter_clean_architecture/feature/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late AuthLocalDataSourceImpl localDataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource =
        AuthLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  void verifySharedPreferencesCalled() {
    verify(
      () => mockSharedPreferences.getString(Constants.kAccessToken),
    ).called(1);
  }

  void mockReturnSharedPreferences({
    String? mockReturn,
    bool isException = false,
  }) {
    switch (isException) {
      case true:
        when(
          () => mockSharedPreferences.getString(Constants.kAccessToken),
        ).thenThrow(Exception());
      default:
        when(
          () => mockSharedPreferences.getString('access_token'),
        ).thenReturn(
          mockReturn,
        );
    }
  }

  group('isAuthenticated', () {
    test('Should check user is authenticated', () {
      mockReturnSharedPreferences(
        mockReturn: FixtureReader.getJsonData('access_token.json'),
      );

      expect(localDataSource.isAuthenticated(), true);
      verifySharedPreferencesCalled();
    });

    test('Should check user is unauthenticated', () {
      mockReturnSharedPreferences();

      expect(localDataSource.isAuthenticated(), false);
      verifySharedPreferencesCalled();
    });

    test('Should throw an exception CacheException', () {
      mockReturnSharedPreferences(isException: true);

      expect(
        () => localDataSource.isAuthenticated(),
        throwsA(isA<CacheException>()),
      );
      verifySharedPreferencesCalled();
    });
  });
}
