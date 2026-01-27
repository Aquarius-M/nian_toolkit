part of '../toolkit.dart';

/// Dio拦截器，用于监听和记录所有网络请求
class DioInspectorInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 记录请求开始时间
    options.extra['start_time'] = DateTime.now();
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 记录响应结束时间
    final startTime = response.requestOptions.extra['start_time'] as DateTime?;
    final endTime = DateTime.now();

    // 创建扩展的Response对象，包含时间信息
    final extendedResponse = _ExtendedResponse(
      response,
      startTime ?? endTime,
      endTime,
    );

    // 添加到HttpContainer中
    DioInspectorInstance.httpContainer.addRequest(extendedResponse);

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 记录错误响应时间
    final startTime = err.requestOptions.extra['start_time'] as DateTime?;
    final endTime = DateTime.now();

    // 创建错误响应
    final errorResponse = Response(
      requestOptions: err.requestOptions,
      statusCode: err.response?.statusCode ?? 0,
      statusMessage: err.response?.statusMessage ?? err.message,
      data: err.response?.data ?? {'error': err.message},
      headers: err.response?.headers ?? Headers(),
    );

    final extendedResponse = _ExtendedResponse(
      errorResponse,
      startTime ?? endTime,
      endTime,
    );

    // 添加到HttpContainer中
    DioInspectorInstance.httpContainer.addRequest(extendedResponse);

    handler.next(err);
  }
}

/// 扩展Response类，添加时间信息
class _ExtendedResponse<T> extends Response<T> {
  final DateTime startTime;
  final DateTime endTime;

  _ExtendedResponse(Response<T> response, this.startTime, this.endTime)
    : super(
        data: response.data,
        headers: response.headers,
        requestOptions: response.requestOptions,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        redirects: response.redirects,
        extra: response.extra,
      );

  /// 请求开始时间（毫秒时间戳）
  int get startTimeMilliseconds => startTime.millisecondsSinceEpoch;
}

/// 为Response添加扩展方法
extension ResponseExtension on Response {
  DateTime get startTime {
    if (this is _ExtendedResponse) {
      return (this as _ExtendedResponse).startTime;
    }
    return DateTime.now();
  }

  DateTime get endTime {
    if (this is _ExtendedResponse) {
      return (this as _ExtendedResponse).endTime;
    }
    return DateTime.now();
  }

  int get startTimeMilliseconds {
    if (this is _ExtendedResponse) {
      return (this as _ExtendedResponse).startTimeMilliseconds;
    }
    return DateTime.now().millisecondsSinceEpoch;
  }
}
