import 'package:flutter_clean_architecture/feature/auth/domain/repositories/auth_repository.dart';

class AuthUseCase {
  const AuthUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<bool> isAuthenticated() => _authRepository.isAuthenticated();

  Future<void> logout() => _authRepository.logout();
}
