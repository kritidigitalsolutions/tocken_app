import 'package:token_app/data/network/network_api_service.dart';
import 'package:token_app/model/response_model/home/location_res_model.dart';
import 'package:token_app/resources/app_url.dart';

class LocationRepo {
  final _api = NetworkApiService();

  Future<LocationModel> searchCity(String city) async {
    try {
      final uri = "${AppUrl.city}?query=$city";
      final res = await _api.getApi(uri);
      return LocationModel.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }
}
