import 'package:token_app/data/network/network_api_service.dart';
import 'package:token_app/model/response_model/post_property_model/rent_sell_res_model.dart';
import 'package:token_app/resources/app_url.dart';

class PostPropertyRepo {
  final _api = NetworkApiService();

  // Post property

  Future<void> postProperty(RentSellResModel model) async {
    try {
      final res = await _api.postHeaderApi(AppUrl.postProperty, model.toJson());
      print(res);
    } catch (e) {
      rethrow;
    }
  }
}
