import 'package:flutter/material.dart';
import 'package:token_app/data/api_response.dart';
import 'package:token_app/model/response_model/home/location_res_model.dart';
import 'package:token_app/repository/location_repo.dart';

class LocationProvider extends ChangeNotifier {
  final LocationRepo _repo = LocationRepo();

  bool isLoading = false;
  ApiResponse<LocationModel> locations = ApiResponse.completed(null);

  Future<void> searchCity(String query) async {
    if (query.isEmpty) {
      locations = ApiResponse.completed(null);
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final res = await _repo.searchCity(query);
      locations = ApiResponse.completed(res);
    } catch (e) {
      locations = ApiResponse.error("Something went wrong");
    }

    isLoading = false;
    notifyListeners();
  }
}
