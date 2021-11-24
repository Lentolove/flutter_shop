import 'package:dio/dio.dart';
import 'package:flutter_shop/constant/app_string.dart';
import 'package:flutter_shop/router/application.dart';
import 'package:flutter_shop/router/router_path.dart';
import 'package:flutter_shop/utils/shared_preferences_util.dart';

///数据请求单例类，工厂模式
class HttpUtil {
  static HttpUtil get instance => _getInstance();

  static HttpUtil? _httpUtil;

  static HttpUtil _getInstance() {
    _httpUtil ??= HttpUtil();
    return _httpUtil!;
  }

  late Dio _dio;

  HttpUtil() {
    BaseOptions options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 5000,
    );
    _dio = Dio(options);

    ///添加拦截器：https://github.com/flutterchina/dio/blob/master/example/interceptor_lock.dart
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (option, handler) async {
      print("========================请求数据===================");
      print("url=${option.uri.toString()}");
      print("params=${option.data}");
      _dio.lock();
      //todo 如果token存在在请求头加上token

      await SharedPreferencesUtil.instance
          .getString(AppStrings.TOKEN)
          .then((token) {
        options.headers[AppStrings.TOKEN] = token;
        print("token=${token}");
      });
      _dio.unlock();
      handler.next(option);
    }, onResponse: (response, handler) {
      print("========================请求数据===================");
      print("code=${response.statusCode}");
      print("response=${response.data}");
      if (response.data[AppStrings.ERR_NO] == 501) {
        Application.navigatorKey.currentState!.pushNamed(Routers.login);
        // handler.reject(
        //     DioError(requestOptions: response.requestOptions, error: '未登录'));
      }
      handler.next(response);
    }, onError: (e, handler) {
      print("========================请求数据===================");
      print("onError = ${e.message}");
      handler.reject(e);
      return;
    }));
  }

  ///发送一个get请求
  Future get(String url,
      {Map<String, dynamic>? parameters, Options? options}) async {
    Response response;
    if (parameters != null && options != null) {
      response =
          await _dio.get(url, queryParameters: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await _dio.get(url, queryParameters: parameters);
    } else if (parameters == null && options != null) {
      response = await _dio.get(url, options: options);
    } else {
      response = await _dio.get(url);
    }
    return response.data;
  }

  ///发送一个 post 请求
  Future post(String url,
      {Map<String, dynamic>? parameters, Options? options}) async {
    Response response;
    if (parameters != null && options != null) {
      response = await _dio.post(url, data: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await _dio.post(url, data: parameters);
    } else if (parameters == null && options != null) {
      response = await _dio.post(url, options: options);
    } else {
      response = await _dio.post(url);
    }
    return response.data;
  }
}
