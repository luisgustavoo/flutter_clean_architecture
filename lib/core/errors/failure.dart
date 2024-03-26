class Failure implements Exception {
  const Failure({
    this.message,
  });
  final String? message;
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NoLocalDataFailure extends Failure {}
