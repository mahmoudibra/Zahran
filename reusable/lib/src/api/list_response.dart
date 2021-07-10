part of api_helpers;

class ApiListResponse<TItem> extends _BaseResponse<List<TItem>> {
  int? total;
  ApiListResponse();
  ApiListResponse.fromJson({
    required int skip,
    required int pageSize,
    required dio.Response response,
    required TItem Function(Map<String, dynamic> json) mapItem,
    required ApiMessages messages,
    required ResolveResponseCallback resolveResponse,
    required String listTotalKey,
  }) {
    try {
      jsonData = resolveResponse(response);
      headers = response.headers.map;

      dynamic errors = jsonData!['errors'] ??
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
      var list = <TItem>[];

      if (jsonData!['data'] != null) {
        List<dynamic> data = jsonData!['data'];
        list = data
            .map((item) => mapItem(
                (item is Map) ? item as Map<String, dynamic> : {'item': item}))
            .toList();
      }
      if (jsonData!['status'] == null) {
        status = response.statusCode ?? 0;
      } else {
        status = jsonData!['status'] is int
            ? jsonData!['status']
            : (jsonData!['status'] == true ? 200 : 400);
      }
      data = list;
      message = _error;
      total = (jsonData![listTotalKey] as int?) ??
          (data!.length < pageSize
              ? skip + data!.length
              : skip + data!.length + pageSize);
      key = jsonData!['key'] ?? '';
    } catch (e) {
      status = response.statusCode == 200 ? 500 : response.statusCode ?? 0;
      if (response.statusCode == 401 || response.statusCode == 403) {
        message = messages.authorizationMessage;
      } else if (response.statusCode == 404) {
        message = messages.notFoundMessage;
      } else {
        message = e.toString();
      }
      extraError = e.toString();
      key = 'json_exption';
    }
    if (status != 200) {
      throw ApiFetchException(
        message: message,
        response: response,
        json: jsonData,
        retryCount: 0,
      );
    }
  }

  @override
  String toString() {
    return message ?? 'There is no error';
  }
}
