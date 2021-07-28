library api_helpers;

import 'dart:async';
import 'dart:convert';

import 'package:ansi_logger/ansi_logger.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  static final observer = _Observer();
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
  Duration get connectTimeout => Duration(seconds: 15);
  Future<Map<String, String>>? getHeaders(ROptions options);
  Future<bool> onError(ApiFetchException error);
  Future authenticate(IAuthenticated user) async {}
  Future<T> _handleError<X, T>({
    required Future<dio.Response<X>> Function() action,
    required ResolveResponseCallback resolve,
    required T Function(dio.Response<X> response) map,
    int retryCount = 0,
  }) async {
    ApiFetchException exception;
    try {
      var res = await action();
      var _r = map(res);
      if (_r is ApiDataResponse) {
        if (_r.data is IAuthenticated) {
          if ((_r.data as IAuthenticated).authenticated) {
            await authenticate(_r.data);
          }
        }
      }
      return _r;
    } on ApiFetchException catch (e) {
      exception = e._withCount(retryCount);
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          exception = ApiFetchException(
            message: messages.connectionTimeOutMessage,
            response: e.response,
            retryCount: retryCount,
          );
          break;
        case DioErrorType.response:
          exception = ApiDataResponse.fromJson(
            response: e.response!,
            mapItem: (json) => json,
            messages: messages,
            resolveResponse: resolve,
            throwError: false,
          ).exception(e.response!)._withCount(retryCount);
          break;
        case DioErrorType.cancel:
          exception = ApiFetchException(
            message: e.message,
            response: e.response,
            retryCount: retryCount,
            isCancel: true,
          );
          break;
        case DioErrorType.other:
          exception = ApiFetchException(
            message: e.message,
            response: e.response,
            retryCount: retryCount,
          );
      }
    } catch (e) {
      exception = ApiFetchException(
        message: e.toString(),
        retryCount: retryCount,
      );
    }
    var res = await onError(exception);
    if (res) {
      return await _handleError(
        action: action,
        resolve: resolve,
        map: map,
        retryCount: retryCount + 1,
      );
    }
    throw exception;
  }

  // do with
  Future<T> _doWith<X, T>({
    required ROptions options,
    required ResolveResponseCallback resolve,
    required Future<dio.Response<X>> Function(dio.Dio client) action,
    required T Function(dio.Response<X> response) map,
  }) async {
    var fn = () async {
      var client = Dio(BaseOptions(
        sendTimeout: sendTimeOut.inMilliseconds,
        receiveTimeout: receiveTimeout.inMilliseconds,
        connectTimeout: connectTimeout.inMilliseconds,
        receiveDataWhenStatusError: true,
        baseUrl: baseUrl.toString(),
        headers: await _resplvedHeaders(options),
      ));
      client.interceptors.add(_Interceptor());
      return client;
    };

    return await _handleError<X, T>(
      action: () async => action(await fn()),
      resolve: resolve,
      map: map,
    );
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
    return await _doWith(
      options: ROptions(path, queryParams),
      resolve: resolveResponse ?? this.resolveResponse,
      action: (client) => client.get(
        path,
        queryParameters: queryParams,
        cancelToken: cancelToken,
      ),
      map: (response) => ApiDataResponse.fromJson(
        response: response,
        mapItem: mapItem,
        messages: messages,
        resolveResponse: resolveResponse ?? this.resolveResponse,
      ),
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
    return await _doWith(
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
      map: (response) => ApiListResponse.fromJson(
        response: response,
        mapItem: mapItem,
        messages: messages,
        resolveResponse: resolveResponse ?? this.resolveResponse,
        listTotalKey: listTotalKey ?? this.listTotalKey,
        pageSize: pageSize,
        skip: 0,
      ),
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
    return await _doWith(
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
      map: (response) => ApiDataResponse.fromJson(
        response: response,
        mapItem: mapItem,
        messages: messages,
        resolveResponse: resolveResponse ?? this.resolveResponse,
      ),
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
    return await _doWith(
      options: ROptions(path, queryParams),
      resolve: resolveResponse ?? this.resolveResponse,
      action: (client) => client.patch(
        path,
        queryParameters: queryParams,
        data: data,
        cancelToken: cancelToken,
      ),
      map: (response) => ApiDataResponse.fromJson(
        response: response,
        mapItem: mapItem,
        messages: messages,
        resolveResponse: resolveResponse ?? this.resolveResponse,
      ),
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
    return await _doWith(
      options: ROptions(path, queryParams),
      resolve: resolveResponse ?? this.resolveResponse,
      action: (client) => client.put(
        path,
        queryParameters: queryParams,
        data: data,
        cancelToken: cancelToken,
      ),
      map: (response) => ApiDataResponse.fromJson(
        response: response,
        mapItem: mapItem,
        messages: messages,
        resolveResponse: resolveResponse ?? this.resolveResponse,
      ),
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
    return await _doWith(
      options: ROptions(path, queryParams),
      resolve: resolveResponse ?? this.resolveResponse,
      action: (client) => client.head(
        path,
        queryParameters: queryParams,
        data: data,
        cancelToken: cancelToken,
      ),
      map: (response) => ApiDataResponse.fromJson(
        response: response,
        mapItem: mapItem,
        messages: messages,
        resolveResponse: resolveResponse ?? this.resolveResponse,
      ),
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
    return await _doWith(
      options: ROptions(path, queryParams),
      resolve: resolveResponse ?? this.resolveResponse,
      action: (client) => client.delete(
        path,
        queryParameters: queryParams,
        data: data,
        cancelToken: cancelToken,
      ),
      map: (response) => ApiDataResponse.fromJson(
        response: response,
        mapItem: mapItem,
        messages: messages,
        resolveResponse: resolveResponse ?? this.resolveResponse,
      ),
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
      action: () => client.download(
        path,
        savePath,
        queryParameters: queryParams,
        data: data,
        onReceiveProgress: (received, total) =>
            _onrogress(received, total, onReceiveProgress),
        cancelToken: cancelToken,
      ),
      resolve: resolveResponse,
      map: (x) => x,
    );

    return result.data;
  }
}

class _Observer extends NavigatorObserver {
  Route? currentRoute;
  bool get isPopupRout => currentRoute != null && currentRoute is PopupRoute;
  @override
  void didPop(Route route, Route? previousRoute) {
    currentRoute = previousRoute;
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    currentRoute = route;
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    currentRoute = previousRoute;
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    currentRoute = newRoute;
  }
}
