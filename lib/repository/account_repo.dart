import 'dart:io';

import 'package:dio/dio.dart';
import 'package:token_app/data/network/network_api_service.dart';
import 'package:token_app/model/request_model/account/feedback_req_model.dart';
import 'package:token_app/model/response_model/account/profile_edit_res_model.dart';
import 'package:token_app/resources/app_url.dart';
import 'package:token_app/utils/local_storage.dart';

class AccountRepo {
  final _api = NetworkApiService();
  final Dio _dio = Dio();
  // Feedback

  Future<void> postFeedback(FeedbackReqModel model) async {
    try {
      await _api.postHeaderApi(AppUrl.feedback, model.toJson());
    } catch (e) {
      rethrow;
    }
  }

  // phone number privacy

  Future<void> phonePrivacy(bool isHide) async {
    try {
      await _api.patchHeaderApi(AppUrl.phonePrivacy, {
        "isPhonePrivate": isHide,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<ProfileEditResModel> editProfile(
    String fName,
    String lName,
    String gstNumber,
  ) async {
    try {
      final res = await _api.patchHeaderApi(AppUrl.profileEdit, {
        "firstName": fName,
        "lastName": lName,
        "gstNumber": gstNumber,
      });

      return ProfileEditResModel.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }

  // Edit profile

  Future<ProfileEditResModel> updateProfileImage(File imageFile) async {
    final token = await LocalStorageService.getToken();
    try {
      FormData formData = FormData.fromMap({
        "profileImage": await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });

      final response = await _dio.patch(
        AppUrl.profileEdit,
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer $token",
          },
        ),
      );

      // assuming API returns imageUrl
      return ProfileEditResModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
