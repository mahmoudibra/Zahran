library api_helpers;

import 'dart:async';
import 'dart:convert';

import 'package:ansi_logger/ansi_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:reusable/l10n/gen_l10n/reusable_localizations.dart';
import 'package:reusable/reusable.dart';

part 'api_exption.dart';
part 'api_messages.dart';
part 'auth_helper.dart';
part 'base.dart';
part 'data_response.dart';
part 'list_response.dart';
//! help method

void _onrogress(int received, int total, Function(double)? onProgress) {
  if (total != -1 && onProgress != null) {
    onProgress((received / total * 100));
  }
}

typedef MapingCallBack<T> = T Function(Map<String, dynamic> json);
typedef ResolveResponseCallback = Map<String, dynamic> Function(
    dio.Response response);

class ROptions {
  final String path;
  final Map<String, dynamic>? queryParams;
  final Map<String, dynamic>? data;

  ROptions(this.path, this.queryParams, [this.data]);
}

abstract class BaseRepositry {
  Uri get baseUrl;

  Map<String, dynamic> resolveResponse(dio.Response response) {
    try {
      if (response.data is Map) return response.data;
      var _json = jsonDecode(response.data ?? '');
      if (_json is Map<String, dynamic>) {
        return _json;
      } else {
        return {'data': _json};
      }
    } catch (e) {
      return {'data': response.data};
    }
  }

  ApiMessages get messages => ApiMessages.of(context);
  BuildContext get context;
  String? get language;
  String get listTotalKey;
  Duration get sendTimeOut => Duration(seconds: 15);
  Duration get receiveTimeout => Duration(seconds: 15);
  Duration get connectTimeout => Duration(seconds: 5);
  Future<Map<String, String>>? getHeaders(ROptions options);
  void onError(ApiFetchException error);

  Future<dio.Response<X>> _handleError<X>(
      Future<dio.Response<X>> future, ResolveResponseCallback resolve) async {
    try {
      var res = await future;
      return res;
    } on ApiFetchException {
      rethrow;
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          throw ApiFetchException(
            messages.connectionTimeOutMessage,
            response: e.response,
            onError: onError,
          );
        case DioErrorType.response:
          throw ApiDataResponse.fromJson(
            response: e.response!,
            mapItem: (json) => json,
            messages: messages,
            resolveResponse: resolve,
            onError: onError,
          ).exception(e.response!, onError);
        case DioErrorType.cancel:
          throw ApiFetchException(
            e.message,
            response: e.response,
            isCancel: true,
            onError: onError,
          );
        case DioErrorType.other:
          throw ApiFetchException(
            e.message,
            response: e.response,
            onError: onError,
          );
      }
    } catch (e) {
      throw ApiFetchException(e.toString(), onError: onError);
    }
  }

  // do with
  Future<dio.Response<String>> _doWith({
    required ROptions options,
    required ResolveResponseCallback resolve,
    required Future<dio.Response<String>> Function(dio.Dio client) action,
  }) async {
    var client = Dio(BaseOptions(
      sendTimeout: sendTimeOut.inMilliseconds,
      receiveTimeout: receiveTimeout.inMilliseconds,
      connectTimeout: connectTimeout.inMilliseconds,
      receiveDataWhenStatusError: true,
      baseUrl: baseUrl.toString(),
      headers: await _resplvedHeaders(options),
    ));
    client.interceptors.add(_Interceptor());

    return await _handleError<String>(action(client), resolve);
  }

  // resolved headers
  Future<Map<String, String>> _resplvedHeaders(ROptions options) async {
    var headers = await getHeaders(options);
    return {
      'Accept': 'application/json',
      if (language != null) 'Accept-Language': language!,
      if (headers != null) ...headers
    };
  }

  Future<ApiDataResponse<T>> get<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    required MapingCallBack<T> mapItem,
    ResolveResponseCallback? resolveResponse,
    CancelToken? cancelToken,
  }) async {
    var response = await _doWith(
      options: ROptions(path, queryParams),
      resolve: resolveResponse ?? this.resolveResponse,
      action: (client) => client.get(
        path,
        queryParameters: queryParams,
        cancelToken: cancelToken,
      ),
    );

    return ApiDataResponse.fromJson(
      response: response,
      mapItem: mapItem,
      messages: messages,
      resolveResponse: resolveResponse ?? this.resolveResponse,
      onError: onError,
    );
  }

  Future<ApiListResponse<T>> paging<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    ResolveResponseCallback? resolveResponse,
    required MapingCallBack<T> mapItem,
    CancelToken? cancelToken,
    String? listTotalKey,
    int pageSize = 20,
    required int skip,
    String skipKey = 'skipCount',
    String pageSizeKey = 'pageSize',
  }) async {
    var response = await _doWith(
      options: ROptions(path, queryParams),
      resolve: resolveResponse ?? this.resolveResponse,
      action: (client) => client.get(
        path,
        cancelToken: cancelToken,
        queryParameters: {
          skipKey: skip,
          pageSizeKey: pageSize,
          if (queryParams != null) ...queryParams,
        },
      ),
    );

    return ApiListResponse.fromJson(
      response: response,
      mapItem: mapItem,
      messages: messages,
      resolveResponse: resolveResponse ?? this.resolveResponse,
      listTotalKey: listTotalKey ?? this.listTotalKey,
      pageSize: pageSize,
      onError: onError,
      skip: 0,
    );
  }

  Future<ApiDataResponse<T>> post<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    required MapingCallBack<T> mapItem,
    Map<String, dynamic> data = const <String, dynamic>{},
    CancelToken? cancelToken,
    ResolveResponseCallback? resolveResponse,
    ValueChanged<double>? onSendProgress,
    bool formData = false,
  }) async {
    var response = await _doWith(
      options: ROptions(path, queryParams),
      resolve: resolveResponse ?? this.resolveResponse,
      action: (client) => client.post(
        path,
        queryParameters: queryParams,
        data: formData ? FormData.fromMap(data) : data,
        cancelToken: cancelToken,
        onSendProgress: (received, total) =>
            _onrogress(received, total, onSendProgress),
      ),
    );

    return ApiDataResponse.fromJson(
      response: response,
      mapItem: mapItem,
      messages: messages,
      onError: onError,
      resolveResponse: resolveResponse ?? this.resolveResponse,
    );
  }

  Future<ApiDataResponse<T>> patch<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    required MapingCallBack<T> mapItem,
    Map<String, dynamic> data = const <String, dynamic>{},
    CancelToken? cancelToken,
    ResolveResponseCallback? resolveResponse,
  }) async {
    var response = await _doWith(
      options: ROptions(path, queryParams),
      resolve: resolveResponse ?? this.resolveResponse,
      action: (client) => client.patch(
        path,
        queryParameters: queryParams,
        data: data,
        cancelToken: cancelToken,
      ),
    );
    return ApiDataResponse.fromJson(
      response: response,
      mapItem: mapItem,
      messages: messages,
      onError: onError,
      resolveResponse: resolveResponse ?? this.resolveResponse,
    );
  }

  Future<ApiDataResponse<T>> put<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    required MapingCallBack<T> mapItem,
    Map<String, dynamic> data = const <String, dynamic>{},
    CancelToken? cancelToken,
    ResolveResponseCallback? resolveResponse,
  }) async {
    var response = await _doWith(
      options: ROptions(path, queryParams),
      resolve: resolveResponse ?? this.resolveResponse,
      action: (client) => client.put(
        path,
        queryParameters: queryParams,
        data: data,
        cancelToken: cancelToken,
      ),
    );
    return ApiDataResponse.fromJson(
      response: response,
      mapItem: mapItem,
      messages: messages,
      onError: onError,
      resolveResponse: resolveResponse ?? this.resolveResponse,
    );
  }

  Future<ApiDataResponse<T>> head<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    required MapingCallBack<T> mapItem,
    Map<String, dynamic> data = const <String, dynamic>{},
    CancelToken? cancelToken,
    ResolveResponseCallback? resolveResponse,
  }) async {
    var response = await _doWith(
      options: ROptions(path, queryParams),
      resolve: resolveResponse ?? this.resolveResponse,
      action: (client) => client.head(
        path,
        queryParameters: queryParams,
        data: data,
        cancelToken: cancelToken,
      ),
    );
    return ApiDataResponse.fromJson(
      response: response,
      mapItem: mapItem,
      messages: messages,
      onError: onError,
      resolveResponse: resolveResponse ?? this.resolveResponse,
    );
  }

  Future<ApiDataResponse<T>> delete<T>({
    required String path,
    Map<String, dynamic>? queryParams,
    ResolveResponseCallback? resolveResponse,
    required MapingCallBack<T> mapItem,
    Map<String, dynamic> data = const <String, dynamic>{},
    CancelToken? cancelToken,
    Encoding? encoding,
  }) async {
    var response = await _doWith(
      options: ROptions(path, queryParams),
      resolve: resolveResponse ?? this.resolveResponse,
      action: (client) => client.delete(
        path,
        queryParameters: queryParams,
        data: data,
        cancelToken: cancelToken,
      ),
    );
    return ApiDataResponse.fromJson(
      response: response,
      mapItem: mapItem,
      messages: messages,
      onError: onError,
      resolveResponse: resolveResponse ?? this.resolveResponse,
    );
  }

  Future download({
    required String path,
    required String savePath,
    CancelToken? cancelToken,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    ValueChanged<double>? onReceiveProgress,
  }) async {
    var client = Dio(BaseOptions(
      sendTimeout: sendTimeOut.inMilliseconds,
      receiveTimeout: receiveTimeout.inMilliseconds,
      connectTimeout: connectTimeout.inMilliseconds,
      receiveDataWhenStatusError: true,
      baseUrl: baseUrl.toString(),
      headers: await _resplvedHeaders(ROptions(path, queryParams)),
    ));
    client.interceptors.add(_Interceptor());

    var result = await _handleError(
      client.download(
        path,
        savePath,
        queryParameters: queryParams,
        data: data,
        onReceiveProgress: (received, total) =>
            _onrogress(received, total, onReceiveProgress),
        cancelToken: cancelToken,
      ),
      resolveResponse,
    );

    return result.data;
  }
}
