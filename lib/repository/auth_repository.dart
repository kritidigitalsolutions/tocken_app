import 'package:token_app/data/network/network_api_service.dart';
import 'package:token_app/resources/app_url.dart';

class AuthRepository {
  final _api = NetworkApiService();

  Future<dynamic> loginWithPhone(String mobile) async {
    try {
      final response = await _api.postApi(AppUrl.sendOtp, {"phone": mobile});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // verify otp

  Future<dynamic> verifyOtp(String mobile, String otp) async {
    try {
      final response = await _api.postApi(AppUrl.verifyOtp, {"phone": mobile});
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
