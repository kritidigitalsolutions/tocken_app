import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:token_app/data/network/network_api_service.dart';
import 'package:token_app/model/request_model/post_property/co_living_req_model.dart';
import 'package:token_app/model/request_model/post_property/pg_req_model.dart';
import 'package:token_app/model/request_model/post_property/rent_sell_req_model.dart';
import 'package:token_app/resources/app_url.dart';
import 'package:token_app/utils/local_storage.dart';

class PostPropertyRepo {
  final _api = NetworkApiService();
  final Dio _dio = Dio();

  // Post property

  Future<Map<String, dynamic>> postProperty(RentSellReqModel model) async {
    try {
      final res = await _api.postHeaderApi(AppUrl.postProperty, model.toJson());
      print(res);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  // Post pg property

  Future<Map<String, dynamic>> pgPostProperty(PgReqModel model) async {
    try {
      final res = await _api.postHeaderApi(AppUrl.postProperty, model.toJson());
      print(res);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  // post image

  Future<Response> uploadPgImages({
    required String propertyId,
    required List<String> images,
  }) async {
    try {
      final token = await LocalStorageService.getToken();

      final url = "${AppUrl.postProperty}/$propertyId/photos";

      List<MultipartFile> multipartImages = images.map((path) {
        return MultipartFile.fromFileSync(path);
      }).toList();

      FormData formData = FormData.fromMap({
        "photos": multipartImages, // backend key
      });

      final response = await _dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
          },
        ),
        onSendProgress: (sent, total) {
          debugPrint(
            "Upload progress: ${(sent / total * 100).toStringAsFixed(0)}%",
          );
        },
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // co-living

  Future<Map<String, dynamic>> colivingPostProperty(
    CoLivingReqModel model,
  ) async {
    try {
      final res = await _api.postHeaderApi(AppUrl.postProperty, model.toJson());
      print(res);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
