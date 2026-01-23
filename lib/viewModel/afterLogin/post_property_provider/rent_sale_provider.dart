import 'package:flutter/material.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/pg_provider.dart';

class RentSaleProvider extends ChangeNotifier {
  /// Rent - resident ====================
  ///

  // Furniture type

  String? furnishType;

  final List<String> furnishTypeList = [
    "Fully Furnished",
    "Semi Furnished",
    "Unfurnished",
  ];

  void setFurnishType(String value) {
    furnishType = value;
    notifyListeners();
  }

  int get minRequiredAmenities {
    if (furnishType == "Fully Furnished") return 6;
    if (furnishType == "Semi Furnished") return 3;
    return 0;
  }

  bool get canOpenFurnishing =>
      furnishType == "Fully Furnished" || furnishType == "Semi Furnished";

  bool get isAmenitiesValid => totalAmenities() >= minRequiredAmenities;
  int totalAmenities() {
    return amenities.values.fold(0, (sum, val) => sum + val);
  }
}
