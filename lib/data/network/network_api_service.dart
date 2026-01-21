import 'dart:io';
import 'package:dio/dio.dart';
import 'package:token_app/data/app_exception.dart';
import 'base_api_service.dart';

class NetworkApiService extends BaseApiService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
    ),
  );

  /* ---------------- GET ---------------- */
  @override
  Future<dynamic> getApi(String url) async {
    print(url);
    try {
      final response = await _dio.get(url);
      print(returnResponse(response));
      return returnResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } on SocketException {
      throw NoInternetException();
    }
  }

  /* ---------------- POST ---------------- */
  @override
  Future<dynamic> postApi(String url, dynamic data) async {
    try {
      final response = await _dio.post(url, data: data);
      return returnResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } on SocketException {
      throw NoInternetException();
    }
  }

  /* ---------------- PUT ---------------- */
  @override
  Future<dynamic> putApi(String url, dynamic data) async {
    try {
      final response = await _dio.put(url, data: data);
      return returnResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } on SocketException {
      throw NoInternetException();
    }
  }

  /* ---------------- DELETE ---------------- */
  @override
  Future<dynamic> deleteApi(String url) async {
    try {
      final response = await _dio.delete(url);
      return returnResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } on SocketException {
      throw NoInternetException();
    }
  }

  /* ---------------- RESPONSE HANDLER ---------------- */
  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;

      case 400:
        throw BadRequestException(
          response.data.toString(),
          statusCode: response.statusCode,
        );

      case 401:
        throw UnauthorizedException(
          response.data.toString(),
          statusCode: response.statusCode,
        );

      case 403:
        throw ForbiddenException(
          response.data.toString(),
          statusCode: response.statusCode,
        );

      case 404:
        throw NotFoundException(
          response.data.toString(),
          statusCode: response.statusCode,
        );

      case 500:
      default:
        throw InternalServerException(
          response.data.toString(),
          statusCode: response.statusCode,
        );
    }
  }

  /* ---------------- DIO ERROR HANDLER ---------------- */
  Exception _handleDioError(DioException error) {
    final statusCode = error.response?.statusCode;

    switch (statusCode) {
      case 400:
        return BadRequestException('Bad Request', statusCode: 400);
      case 401:
        return UnauthorizedException('Unauthorized', statusCode: 401);
      case 403:
        return ForbiddenException('Forbidden', statusCode: 403);
      case 404:
        return NotFoundException('Not Found', statusCode: 404);
      case 500:
        return InternalServerException(
          'Internal Server Error',
          statusCode: 500,
        );
      default:
        return FetchDataException(
          error.message ?? 'Unexpected Error',
          statusCode: statusCode,
        );
    }
  }
}
