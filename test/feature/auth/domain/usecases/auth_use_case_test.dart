import 'package:flutter_clean_architecture/feature/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/usecases/auth_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthUseCase authUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authUseCase = AuthUseCase(authRepository: mockAuthRepository);
  });

  test('should check if user is authenticated', () {
    when(
      () => mockAuthRepository.isAuthenticated(),
    ).thenReturn(true);

    expect(authUseCase.isAuthenticated(), true);

    verify(
      () => mockAuthRepository.isAuthenticated(),
    ).called(1);

    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should check whether the user has successfully logged out', () {
    when(
      () => mockAuthRepository.logout(),
    ).thenAnswer((_) async => _);

    authUseCase.logout();

    verify(
      () => mockAuthRepository.logout(),
    ).called(1);

    verifyNoMoreInteractions(mockAuthRepository);
  });
}
