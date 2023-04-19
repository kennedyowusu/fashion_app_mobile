class ApiException implements Exception {
  final String message;

  ApiException(this.message, [int? statusCode]);

  @override
  String toString() {
    return message;
  }
}
