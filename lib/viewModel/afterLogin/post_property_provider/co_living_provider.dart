import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/model/request_model/post_property/co_living_req_model.dart';
import 'package:token_app/model/request_model/post_property/common_property_req_model.dart';
import 'package:token_app/repository/post_property_repo.dart';
import 'package:token_app/resources/App_string.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/pg_provider.dart';

class CoLivingProvider extends ChangeNotifier {
  final TextEditingController nameCtr = TextEditingController(
    text: "Amit Kumar",
  );
  final TextEditingController mobileCtr = TextEditingController(
    text: "6397892585",
  );
  final TextEditingController dobCtr = TextEditingController(
    text: "12/01/2010",
  );

  final TextEditingController lanCtr = TextEditingController();
  final TextEditingController hobbCtr = TextEditingController();
  final TextEditingController shiftDate = TextEditingController();

  final TextEditingController aboutYourSelfCtr = TextEditingController();

  final TextEditingController instaCtr = TextEditingController();
  final TextEditingController fbCtr = TextEditingController();
  final TextEditingController linkedinCtr = TextEditingController();

  final TextEditingController occupationCtr = TextEditingController();

  final List<String> genderList = ["Male", "Female", "Other"];
  String propertyCategory = '';
  // for number hide

  bool hideNumber = false;

  void toggleHideNumber(bool value) {
    hideNumber = value;
    notifyListeners();
  }

  // Gender

  String gender = '';

  void selectGender(String value) {
    gender = value;
    notifyListeners();
  }

  // phone privacy

  bool phonePrivacy = false;

  void toggalePhone(bool value) {
    phonePrivacy = value;
    notifyListeners();
  }

  // Occupation

  String? occupation;

  bool get isEmpty => occupation != null && occupation!.isNotEmpty;

  void selectOccupation(String value) {
    occupation = value;
    notifyListeners();
  }

  // Room Details

  String? availableFrom;
  String? bhk;
  Set<String> roomDetails = {};
  final totalFloorsCtrl = TextEditingController();
  final yourFloorCtrl = TextEditingController();

  final furnishTypes = ["Fully Furnished", "Semi Furnished", "Unfurnished"];

  // ================= furniture type =======================

  String? furnishType;
  final bhkOptions = ["1RK", "1BHK", "2BHK", "3BHK", "4BHK", "5BHK"];

  void setFurnishType(String value) {
    furnishType = value;
    notifyListeners();
  }

  bool get canOpenFurnishing =>
      furnishType == "Fully Furnished" || furnishType == "Semi Furnished";

  //===========================///// ====================

  final roomDetailOptions = [
    "Attached Bathroom",
    "Attached Balcony",
    "AC Room",
  ];

  void setDate(String date) {
    availableFrom = date;
    notifyListeners();
  }

  void setBhk(String value) {
    bhk = value;
    notifyListeners();
  }

  void setFurnish(String value) {
    furnishType = value;
    notifyListeners();
  }

  void toggleRoomDetail(String value) {
    if (roomDetails.contains(value)) {
      roomDetails.remove(value);
    } else {
      roomDetails.add(value);
    }
    notifyListeners();
  }

  bool get isValid =>
      availableFrom != null &&
      bhk != null &&
      furnishType != null &&
      totalFloorsCtrl.text.isNotEmpty &&
      yourFloorCtrl.text.isNotEmpty;

  //  amenities ===================

  void toggleItem(List<AmenityModel> list, int index) {
    list[index].isSelected = !list[index].isSelected;
    notifyListeners();
  }

  List<AmenityModel> selectedAmenityModel(List<AmenityModel> list) {
    final selected = list.where((e) => e.isSelected).toList();

    return selected;
  }

  /// ==================
  ///

  //============== Pricing pages ===================

  final rentCtrl = TextEditingController();
  final maintenanceCtrl = TextEditingController();
  final bookingCtrl = TextEditingController();
  final otherCtrl = TextEditingController();

  bool negotiable = false;
  bool utilitiesIncluded = false;

  void toggleNegotiable(bool value) {
    negotiable = value;
    notifyListeners();
  }

  void toggleutilitiesIncludede(bool value) {
    utilitiesIncluded = value;
    notifyListeners();
  }

  List<String> get selectedAmenityTitles {
    return selectedAmenityModel(
      amenitiesList,
    ).map((amenity) => amenity.title).toList();
  }

  List<String> get selectedRulesTitles {
    return selectedAmenityModel(
      preferencesList,
    ).map((amenity) => amenity.title).toList();
  }

  // =========================================

  // =============== Sharing preference ================

  final List<String> partnerGenderList = ["Male", "Female", "Any"];

  final List<String> partnerOccList = [
    "Student",
    "Working Professional",
    "Other",
  ];

  String pGender = '';

  Set<String> selectedPOcc = {};

  bool isSelectedPOcc(value) => selectedPOcc.contains(value);

  void setPGender(String value) {
    pGender = value;
    notifyListeners();
  }

  void setPOcc(String value) {
    if (selectedPOcc.contains(value)) {
      selectedPOcc.remove(value);
    } else {
      selectedPOcc.add(value);
    }

    notifyListeners();
  }

  String minAge = "18 years";
  String maxAge = "60 years";

  void setMinAge(String value) {
    minAge = value;
    notifyListeners();
  }

  void setMaxAge(String value) {
    maxAge = value;
    notifyListeners();
  }

  final List<String> minBudgetList = AppString.minBudgetList;
  final List<String> maxBudgetList = AppString.maxBudgetList;

  String minBudget = "1k";
  String maxBudget = "50k+";

  void setMinBudget(String value) {
    minBudget = value;
    notifyListeners();
  }

  void setMaxBudget(String value) {
    maxBudget = value;
    notifyListeners();
  }

  int parseBudget(String value) {
    value = value.toLowerCase().replaceAll("+", "").trim();

    if (value.contains("k")) {
      return int.tryParse(value.replaceAll("k", "")) ?? 0 * 1000;
    } else {
      return int.tryParse(value) ?? 0;
    }
  }

  // --------------------------------------------------------------
  // CoLiving
  // ----------------------------------------------------------------

  final _repo = PostPropertyRepo();

  Future<void> coLivingPost(BuildContext context) async {
    try {
      final pgProvider = context.read<PgDetailsProvider>();
      final locationObj = Location(
        society: pgProvider.addressCtr.text.trim(),
        locality: pgProvider.localityCtr.text.trim(),
        city: pgProvider.cityCtr.text.trim(),
        // add lat/long, pincode, society if you have
      );
      final model = CoLivingReqModel(
        listingType: "CO_LIVING",
        propertyCategory: propertyCategory,

        coLivingDetails: CoLivingDetails(
          profileImage: "", // upload image url
          name: nameCtr.text,
          mobileNumber: mobileCtr.text,
          isPhonePrivate: hideNumber,
          dateOfBirth: dobCtr.text,
          gender: gender,
          occupation: occupation,
          occupationName: occupationCtr.text,
          languages: lanCtr.text,
          hobbies: hobbCtr.text,
          availableFrom: availableFrom,
          lookingToShiftBy: shiftDate.text,
          bhk: bhk,
          furnishing: Furnishing(
            type: furnishType,
            amenities: AppString.amenities.entries
                .where((e) => e.value > 0)
                .map((e) => Amenity(name: e.key, quantity: e.value))
                .toList(),
          ),
          roomDetails: roomDetails.toList(),
          totalFloors: int.tryParse(totalFloorsCtrl.text),
          yourFloor: int.tryParse(yourFloorCtrl.text),
          societyAmenities: selectedAmenityTitles,

          budgetRange: AgeLimit(
            min: parseBudget(minBudget), // "1k" -> 1000
            max: parseBudget(maxBudget), // "50k+" -> 50000
          ),

          partnerGender: pGender,

          ageLimit: AgeLimit(
            min: int.tryParse(minAge.split(" ").first),
            max: int.tryParse(maxAge.split(" ").first),
          ),

          partnerOccupation: selectedPOcc.toList(),
          preferences: selectedRulesTitles,

          instagramLink: instaCtr.text,
          facebookLink: fbCtr.text,
          linkedInLink: linkedinCtr.text,
        ),

        pricing: CoLivingPricing(
          rent: COLivingRent(
            rentAmount: int.tryParse(rentCtrl.text),
            isElectricityIncluded: utilitiesIncluded,
            isNegotiable: negotiable,
          ),
          additionalCharges: AdditionalCharges(
            maintenanceCharge: int.tryParse(maintenanceCtrl.text),
            bookingAmount: int.tryParse(bookingCtrl.text),
            otherCharge: int.tryParse(otherCtrl.text),
          ),
        ),

        location: locationObj, // your existing Location model
        description: aboutYourSelfCtr.text,
        images: [],
      );

      debugPrint(jsonEncode(model.toJson()), wrapWidth: 1024);

      final res = await _repo.colivingPostProperty(model);

      String propertyId = res['data'];

      await pgProvider.uploadImages(propertyId: propertyId);
      debugPrint("CoLiving Post Success: $res");
    } catch (e) {
      debugPrint("CoLiving Post Error: $e");
      rethrow;
    }
  }
}
