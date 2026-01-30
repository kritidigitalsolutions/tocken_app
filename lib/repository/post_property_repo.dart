import 'package:token_app/data/network/network_api_service.dart';
import 'package:token_app/model/request_model/post_property/pg_req_model.dart';
import 'package:token_app/model/request_model/post_property/rent_sell_req_model.dart';
import 'package:token_app/resources/app_url.dart';

class PostPropertyRepo {
  final _api = NetworkApiService();

  // Post property

  Future<void> postProperty(RentSellReqModel model) async {
    try {
      final res = await _api.postHeaderApi(AppUrl.postProperty, model.toJson());
      print(res);
    } catch (e) {
      rethrow;
    }
  }

  // Post pg property

  Future<void> pgPostProperty(PgReqModel model) async {
    try {
      final res = await _api.postHeaderApi(AppUrl.postProperty, model.toJson());
      print(res);
    } catch (e) {
      rethrow;
    }
  }
}
