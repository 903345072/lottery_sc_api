import 'package:dio/dio.dart';
import 'package:flutterapp2/SharedPreferences/TokenStore.dart';
import 'Code.dart';
import 'DioLogInterceptor.dart';
import 'package:flutterapp2/utils/LoadingUtils.dart';
import 'PrettyDioLogger.dart';
import 'ResponseInterceptors.dart';
import 'ResultData.dart';
import 'Address.dart';
import 'dart:io';
class HttpManager {
  static HttpManager _instance = HttpManager._internal();
  Dio _dio;
  static const CODE_SUCCESS = 200;
  static const CODE_TIME_OUT = -1;
  factory HttpManager() => _instance;
  ///通用全局单例，第一次使用时初始化
  HttpManager._internal({String baseUrl}) {
    if (null == _dio) {
      _dio = new Dio(
          new BaseOptions(baseUrl: Address.BASE_URL, connectTimeout: 35000));
    //_dio.interceptors.add(new DioLogInterceptor());
    //_dio.interceptors.add(new PrettyDioLogger());
    _dio.interceptors.add(new ResponseInterceptors());
    }
  }

  static HttpManager getInstance({String baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名
  HttpManager _baseUrl(String baseUrl) {
    if (_dio != null) {
      _dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  //一般请求，默认域名
  HttpManager _normal() {
    if (_dio != null) {
      if (_dio.options.baseUrl != Address.BASE_URL) {
        _dio.options.baseUrl = Address.BASE_URL;
      }
    }
    return this;
  }

  ///通用的GET请求
  get(api, {params, withLoading = true}) async {

    if (withLoading) {
      LoadingUtils.show();
    }

    Response response;
    try {
      var token = await TokenStore().getToken("token");
      _dio.options.headers = {'Authori-zation':token};
      response = await _dio.get(api, queryParameters: params);
      if (withLoading) {
        LoadingUtils.dismiss();
      }
    } on DioError catch (e) {
      print(e.message);
      if (withLoading) {
        LoadingUtils.dismiss();
      }
      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data['code']);
    }

    return response.data;
  }

  ///通用的POST请求
  post(api, {params, withLoading = true}) async {
    if (withLoading) {
      LoadingUtils.show();
    }

    Response response;

    try {
      var token = await TokenStore().getToken("token");
      _dio.options.headers = {'Authori-zation':token};

      response = await _dio.post(api, data: params);
      if (withLoading) {
        LoadingUtils.dismiss();
      }
    } on DioError catch (e) {
      print(e.message);
      if (withLoading) {
        LoadingUtils.error();
      }

      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data['code']);
    }

    return response.data;
  }
}

ResultData resultError(DioError e) {
  Response errorResponse;
  if (e.response != null) {
    errorResponse = e.response;
  } else {
    errorResponse = new Response(statusCode: 666);
  }
  if (e.type == DioErrorType.CONNECT_TIMEOUT ||
      e.type == DioErrorType.RECEIVE_TIMEOUT) {
    errorResponse.statusCode = Code.NETWORK_TIMEOUT;
  }
  return new ResultData(
    errorResponse.data
      , false, errorResponse.statusCode,"error");
}