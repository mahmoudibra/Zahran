part of api_helpers;

class ApiFetchException implements Exception {
  final String? message;
  final dio.Response? response;
  final bool isCancel;
  Map<String, dynamic>? json;
  ApiFetchException(
    this.message, {
    this.response,
    this.isCancel = false,
    this.json,
    required Function(ApiFetchException error) onError,
  }) {
    onError(this);
  }

  @override
  String toString() {
    return (message?.isNotEmpty == true)
        ? message!
        : response?.statusMessage ?? '';
  }
}
