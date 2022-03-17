class ServerException implements Exception {
  final String errorMessage;
  final int code;

  ServerException({required this.errorMessage, required this.code});
}
