import 'dart:io';
import 'package:dio/dio.dart';
import 'base_api_service.dart';

class NetworkApiService extends BaseApiService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
    ),
  );

  @override
  Future<dynamic> getApi(String url) async {
    try {
      final response = await _dio.get(url);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } on SocketException {
      throw 'No Internet Connection';
    }
  }

  @override
  Future<dynamic> postApi(String url, dynamic data) async {
    try {
      final response = await _dio.post(url, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } on SocketException {
      throw 'No Internet Connection';
    }
  }

  @override
  Future<dynamic> putApi(String url, dynamic data) async {
    try {
      final response = await _dio.put(url, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } on SocketException {
      throw 'No Internet Connection';
    }
  }

  @override
  Future<dynamic> deleteApi(String url) async {
    try {
      final response = await _dio.delete(url);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } on SocketException {
      throw 'No Internet Connection';
    }
  }

  String _handleDioError(DioException error) {
    if (error.response != null) {
      switch (error.response?.statusCode) {
        case 400:
          return 'Bad Request';
        case 401:
          return 'Unauthorized';
        case 403:
          return 'Forbidden';
        case 404:
          return 'Not Found';
        case 500:
          return 'Internal Server Error';
        default:
          return 'Something went wrong';
      }
    } else {
      return error.message ?? 'Unexpected error occurred';
    }
  }
}
