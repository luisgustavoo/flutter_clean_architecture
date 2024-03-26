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

  group('isAuthenticated', () {
    test('Should check user is authenticated', () async {
      when(
        () => mockSharedPreferences.getString('access_token'),
      ).thenReturn(
        FixtureReader.getJsonData('access_token.json'),
      );

      final result = await localDataSource.isAuthenticated();
      expect(result, true);
      verify(
        () => mockSharedPreferences.getString(Constants.kAccessToken),
      ).called(1);
    });

    test('Should check user is unauthenticated', () async {
      when(
        () => mockSharedPreferences.getString(Constants.kAccessToken),
      ).thenReturn(null);

      final result = await localDataSource.isAuthenticated();
      expect(result, false);
      verify(
        () => mockSharedPreferences.getString(Constants.kAccessToken),
      ).called(1);
    });

    test('Should throw an exception CacheException', () async {
      when(
        () => mockSharedPreferences.getString(Constants.kAccessToken),
      ).thenThrow(Exception());

      final call = localDataSource.isAuthenticated;
      expect(call(), throwsA(isA<CacheException>()));
      verify(
        () => mockSharedPreferences.getString(Constants.kAccessToken),
      ).called(1);
    });
  });
}
