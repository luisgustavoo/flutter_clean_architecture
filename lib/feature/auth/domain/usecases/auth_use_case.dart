import 'package:flutter_clean_architecture/feature/auth/domain/repositories/auth_repository.dart';

class AuthUseCase {
  const AuthUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  bool isAuthenticated() => _authRepository.isAuthenticated();

  void logout() => _authRepository.logout();
}
