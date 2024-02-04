class APIException implements Exception {
  final String message;
  final int statusCode;
  const APIException({
    required this.message,
    required this.statusCode,
  });

  @override
  bool operator ==(covariant APIException other) {
    if (identical(this, other)) return true;

    return other.message == message && other.statusCode == statusCode;
  }

  @override
  int get hashCode => message.hashCode ^ statusCode.hashCode;
}
