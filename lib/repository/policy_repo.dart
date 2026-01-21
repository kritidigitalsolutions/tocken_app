import 'package:token_app/data/network/network_api_service.dart';
import 'package:token_app/model/response_model/policy/policy_res_model.dart';
import 'package:token_app/resources/app_url.dart';

class PolicyRepo {
  final _api = NetworkApiService();

  // Policy

  Future<PolicyResModel> fetchPolicy(String type) async {
    final url = "${AppUrl.policy}/$type";
    try {
      final res = await _api.getApi(url);
      return PolicyResModel.fromJson(res);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // About-Us ================

  Future<AboutUsResModel> fetchAboutUs() async {
    final url = AppUrl.aboutUs;
    try {
      final res = await _api.getApi(url);
      return AboutUsResModel.fromJson(res);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
