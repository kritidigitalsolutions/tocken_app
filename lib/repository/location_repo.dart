import 'package:token_app/data/network/network_api_service.dart';
import 'package:token_app/model/response_model/home/location_res_model.dart';
import 'package:token_app/resources/app_url.dart';

class LocationRepo {
  final _api = NetworkApiService();

  Future<List<LocationModel>> searchCity(String city) async {
    try {
      final res = await _api.postHeaderApi(AppUrl.city, {"city": city});
      return res.map((e) => LocationModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
