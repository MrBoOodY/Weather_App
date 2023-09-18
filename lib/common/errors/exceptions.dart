class ServerException implements Exception {
  final String message;

  const ServerException({required this.message});
}

class UnAuthorizedException implements Exception {
  final String message;

  const UnAuthorizedException({required this.message});
}

class UnVerifiedException implements Exception {
  const UnVerifiedException();
}

class UnRegisteredException implements Exception {
  const UnRegisteredException();
}

class DatabaseException implements Exception {
  const DatabaseException();
}
