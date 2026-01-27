import 'package:flutter/material.dart';
import 'package:token_app/model/response_model/home/location_res_model.dart';
import 'package:token_app/repository/location_repo.dart';

class LocationProvider extends ChangeNotifier {
  final LocationRepo _repo = LocationRepo();

  bool isLoading = false;
  List<LocationModel> locations = [];

  Future<void> searchCity(String query) async {
    if (query.isEmpty) {
      locations = [];
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      locations = await _repo.searchCity(query);
    } catch (e) {
      locations = [];
    }

    isLoading = false;
    notifyListeners();
  }
}
