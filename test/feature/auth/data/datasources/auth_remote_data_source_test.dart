import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements Dio {}

void main() {
  late MockHttpClient mockHttpClient;
  late AuthRemoteDataSource remoteDataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSource = AuthRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('logout', () {
    test('should log out successfully', () async {
      when(
        () => mockHttpClient.post<void>(any()),
      ).thenAnswer((_) async => _);
    });
  });
}
