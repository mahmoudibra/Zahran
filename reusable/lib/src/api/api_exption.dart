part of api_helpers;

class ApiFetchException implements Exception {
  final String? message;
  final dio.Response? response;
  final bool isCancel;
  final int retryCount;
  Map<String, dynamic>? json;
  int? get statusCode => response?.statusCode;
  ApiFetchException({
    required this.message,
    this.response,
    required this.retryCount,
    this.isCancel = false,
    this.json,
  });

  @override
  String toString() {
    return (message?.isNotEmpty == true)
        ? message!
        : response?.statusMessage ?? '';
  }

  ApiFetchException _withCount(int count) {
    return ApiFetchException(
      message: message,
      response: response,
      isCancel: isCancel,
      retryCount: retryCount,
      json: json,
    );
  }
}
