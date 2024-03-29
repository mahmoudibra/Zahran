part of api_helpers;

class ApiDataResponse<TItem> extends _BaseResponse<TItem> {
  ApiDataResponse();
  ApiDataResponse.fromJson(
      {required dio.Response response,
      required TItem Function(Map<String, dynamic> json) mapItem,
      required ApiMessages messages,
      required ResolveResponseCallback resolveResponse,
      bool throwError = true}) {
    try {
      jsonData = resolveResponse(response);
      headers = response.headers.map;
      var errors = jsonData!['errors'] ??
          jsonData!['error'] ??
          jsonData!['messages'] ??
          jsonData!['msgs'];
      String? _error;
      if (jsonData!['error'] is String) {
        _error = jsonData!['error'];
      } else if (jsonData!['message'] is String) {
        _error = jsonData!['message'];
      } else if (jsonData!['msg'] is String) {
        _error = jsonData!['msg'];
      } else if (errors != null && errors is Map) {
        _error = errors.values.first.toString();
      } else if (errors != null && errors is List) {
        _error = errors.first.toString();
      }
      if (_error == null) {
        if (response.statusCode == 401 || response.statusCode == 403) {
          _error = messages.authorizationMessage;
        } else if (response.statusCode == 404) {
          _error = messages.notFoundMessage;
        } else {
          _error = '';
        }
      }
      if (jsonData!['status'] == null) {
        status = response.statusCode ?? 0;
      } else {
        status = jsonData!['status'] is int
            ? jsonData!['status']
            : (jsonData!['status'] == true ? 200 : 400);
      }

      data = mapItem(jsonData!['data'] != null && jsonData!['data'] is Map
          ? jsonData!['data']
          : {'data': jsonData!['data'] ?? {}});

      message = _error;
      key = jsonData!['key'] ?? '';
    } catch (e) {
      status = response.statusCode == 200 ? 500 : response.statusCode ?? 0;
      extraError = e.toString();
      message = e.toString();
      key = 'json_exption';
    }
    if (response.statusCode == 401 || response.statusCode == 403) {
      message = messages.authorizationMessage;
    } else if (response.statusCode == 404) {
      message = messages.notFoundMessage;
    }
    if (status < 200 && status >= 300 && throwError) {
      throw exception(response);
    }
  }

  ApiFetchException exception(Response response) {
    return ApiFetchException(
      message: message,
      response: response,
      json: jsonData,
      retryCount: 0,
    );
  }

  @override
  String toString() {
    return message ?? 'There is no error';
  }
}
