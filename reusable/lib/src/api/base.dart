part of api_helpers;

abstract class _BaseResponse<TData> {
  int status = 0;
  String? message;
  String? extraError;
  String? key;
  TData? data;
  Map<String, List<String>>? headers;
  Map<String, dynamic>? jsonData;
}

class _Interceptor extends Interceptor {
  final logger = AnsiLogger(name: 'Dio', length: 100);

  dynamic tryGetMap(dynamic data) {
    try {
      if (data is String) {
        return jsonDecode(data);
      } else {
        return data;
      }
    } catch (e) {
      return data;
    }
  }

  @override
  void onError(dio.DioError err, dio.ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    dynamic requestData;
    List<IFile>? files;
    if (err.requestOptions.data is FormData) {
      var fd = err.requestOptions.data as FormData;
      requestData = {};
      fd.fields.forEach((element) {
        requestData[element.key] = element.value;
      });
      files = [];
      for (var k in fd.files) {
        files.add(IFile(k.value.filename ?? '', k.key, k.value.length));
      }
    } else {
      requestData = err.requestOptions.data;
    }
    logger.logHttp(
      url: err.requestOptions.uri.toString(),
      statusMessage: err.response?.statusMessage ?? '',
      method: err.requestOptions.method,
      statusCode: err.response?.statusCode ?? 0,
      queryParameters: err.requestOptions.queryParameters,
      requestHeaders: err.requestOptions.headers,
      responseHeaders: err.response?.headers.map ?? {},
      response: tryGetMap(err.response?.data),
      requestData: requestData,
      files: files,
    );
  }

  @override
  void onResponse(
      dio.Response response, dio.ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);

    dynamic requestData;
    List<IFile>? files;
    if (response.requestOptions.data is FormData) {
      var fd = response.requestOptions.data as FormData;
      requestData = {};
      fd.fields.forEach((element) {
        requestData[element.key] = element.value;
      });
      files = [];
      for (var k in fd.files) {
        files.add(IFile(k.value.filename ?? '', k.key, k.value.length));
      }
    } else {
      requestData = response.requestOptions.data;
    }
    logger.logHttp(
      url: response.requestOptions.uri.toString(),
      statusMessage: response.statusMessage ?? '',
      method: response.requestOptions.method,
      statusCode: response.statusCode ?? 0,
      queryParameters: response.requestOptions.queryParameters,
      requestHeaders: response.requestOptions.headers,
      responseHeaders: response.headers.map,
      response: tryGetMap(response.data),
      requestData: requestData,
      files: files,
    );
  }
}
