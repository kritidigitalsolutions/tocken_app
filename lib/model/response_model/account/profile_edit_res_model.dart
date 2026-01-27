import 'package:token_app/model/response_model/auth/auth_response_model.dart';

class ProfileEditResModel {
  ProfileEditResModel({
    required this.success,
    required this.message,
    required this.user,
  });

  final bool? success;
  final String? message;
  final User? user;

  factory ProfileEditResModel.fromJson(Map<String, dynamic> json) {
    return ProfileEditResModel(
      success: json["success"],
      message: json["message"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }
}
