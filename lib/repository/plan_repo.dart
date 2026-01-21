import 'package:token_app/data/network/network_api_service.dart';
import 'package:token_app/model/response_model/plan/plan_res_model.dart';
import 'package:token_app/resources/app_url.dart';

class PlanRepo {
  final _api = NetworkApiService();

  // Plans

  Future<PlanResModel> fetchPlans(String type) async {
    final url = "${AppUrl.plans}$type";
    try {
      final res = await _api.getApi(url);
      return PlanResModel.fromJson(res);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Faq ======

  Future<FAQResMOdel> fetchFaq() async {
    final url = AppUrl.faq;
    try {
      final res = await _api.getApi(url);
      return FAQResMOdel.fromJson(res);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
