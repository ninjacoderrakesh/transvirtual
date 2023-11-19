import 'dart:io';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../data/source/local/my_shared_preferences.dart';
import 'package:dio/dio.dart';

import '../../../constants/constant_methods.dart';
import '../../di/di.dart';
import '../local/my_shared_preferences_keys.dart';
import 'api_result_handler.dart';

class MyDio {
  late Dio dio;

  MyDio() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: 'https://wms.transvirtual-stage.com.au:6500/',
      receiveDataWhenStatusError: true,
      connectTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000,
    );
    dio = Dio(baseOptions);
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    printTest('dio');
  }

  Future<ApiResults> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "token": sl<MySharedPref>().getString(key: MySharedKeys.apiToken),
    };
    try {
      var response = await dio.get(endPoint, queryParameters: queryParameters);

      printResponse(response.statusCode.toString());
      printResponse('base:    ${dio.options.baseUrl}');
      printResponse('url:    $endPoint');
      printResponse('header:    ${dio.options.headers}');
      printResponse('queryParameters:    $queryParameters');
      printResponse('response:    $response');
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure("No internet connection");
    } on FormatException {
      return ApiFailure("An error occurred in the data format");
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        // return ApiFailure(e.response!.data['message']);
        return ApiFailure(e.message);
      } else if (e.type == DioErrorType.connectTimeout) {
        // print('check your connection');
        return ApiFailure("Make sure you are connected to the Internet");
      } else if (e.type == DioErrorType.receiveTimeout) {
        // print('unable to connect to the server');
        return ApiFailure("Unable to connect to the server");
      } else {
        return ApiFailure("An error occurred, try again");
      }
    } catch (e) {
      return ApiFailure("An error occurred, try again");
    }
  }

  Future<ApiResults> postData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool formData = false,
    String? token,
  }) async {
    dio.options.headers = {
      "Accept": "application/json",
      // "token": sl<MySharedPref>().getString(key: MySharedKeys.apiToken),
    };

    try {
      var response = await dio.post(
        endPoint,
        data: formData ? FormData.fromMap(data ?? {}) : data,
        queryParameters: queryParameters,
      );
      printResponse('base:    ${dio.options.baseUrl}');
      printResponse('url:    $endPoint');
      printResponse('header:    ${dio.options.headers}');
      printResponse('body:    $data');
      printResponse('response:    $response');
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure("No internet connection");
    } on FormatException {
      return ApiFailure("An error occurred in the data format");
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        // return ApiFailure(e.response!.data['message']);
        return ApiFailure(e.message);
      } else if (e.type == DioErrorType.connectTimeout) {
        // print('check your connection');
        return ApiFailure("Make sure you are connected to the Internet");
      } else if (e.type == DioErrorType.receiveTimeout) {
        // print('unable to connect to the server');
        return ApiFailure("Unable to connect to the server");
      } else {
        return ApiFailure("An error occurred, try again");
      }
    } catch (e) {
      return ApiFailure("An error occurred, try again");
    }
  }
}
