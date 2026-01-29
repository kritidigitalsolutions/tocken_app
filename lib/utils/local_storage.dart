import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:token_app/model/response_model/auth/auth_response_model.dart';

class LocalStorageService {
  static const String _tokenKey = "token";
  static const String _userKey = "user";
  static const String _isLoginKey = "isLogin";

  /// Save user data after login
  static Future<void> saveUserData(UserResModel model) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_tokenKey, model.token ?? "");
    await prefs.setBool(_isLoginKey, true);

    if (model.user != null) {
      await prefs.setString(_userKey, jsonEncode(_userToJson(model.user!)));
    }
  }

  static Future<void> updateUserData({
    required String firstName,
    required String lastName,
    required String gstNumber,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final userString = prefs.getString(_userKey);
    if (userString == null) return;

    final Map<String, dynamic> userMap = jsonDecode(userString);

    User oldUser = User.fromJson(userMap);

    final updatedUser = User(
      id: oldUser.id,
      name: "$firstName $lastName",
      username: oldUser.username,
      firstName: firstName,
      lastName: lastName,
      email: oldUser.email,
      phone: oldUser.phone,
      profileImage: oldUser.profileImage,
      userType: oldUser.userType,
      gstNumber: gstNumber,
    );

    await prefs.setString(_userKey, jsonEncode(updatedUser.toJson()));
  }

  // update image

  static Future<void> updateUserImage({required String image}) async {
    final prefs = await SharedPreferences.getInstance();

    final userString = prefs.getString(_userKey);
    if (userString == null) return;

    final Map<String, dynamic> userMap = jsonDecode(userString);

    User oldUser = User.fromJson(userMap);

    final updatedUser = User(
      id: oldUser.id,
      name: oldUser.name,
      username: oldUser.username,
      firstName: oldUser.firstName,
      lastName: oldUser.lastName,
      email: oldUser.email,
      phone: oldUser.phone,
      profileImage: image,
      userType: oldUser.userType,
      gstNumber: oldUser.gstNumber,
    );

    await prefs.setString(_userKey, jsonEncode(updatedUser.toJson()));
  }

  /// Get token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Get user object
  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_userKey);

    if (userString == null) return null;

    return User.fromJson(jsonDecode(userString));
  }

  /// Check login
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoginKey) ?? false;
  }

  /// Clear all data (logout)
  static Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Map<String, dynamic> _userToJson(User user) {
    return {
      "_id": user.id,
      "name": user.name,
      "firstName": user.firstName,
      "lastName": user.lastName,
      "email": user.email,
      "phone": user.phone,
      "profileImage": user.profileImage,
    };
  }
}
