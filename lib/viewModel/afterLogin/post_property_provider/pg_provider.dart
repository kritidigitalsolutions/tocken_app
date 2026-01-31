import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:token_app/model/request_model/post_property/common_property_req_model.dart';
import 'package:token_app/model/request_model/post_property/pg_req_model.dart';
import 'package:token_app/model/request_model/post_property/rent_sell_req_model.dart';
import 'package:token_app/model/response_model/auth/auth_response_model.dart';
import 'package:token_app/repository/post_property_repo.dart';
import 'package:token_app/resources/App_string.dart';
import 'package:token_app/utils/app_snackbar.dart';
import 'package:token_app/utils/local_storage.dart';

enum SecurityDepositType { fixed, multiple, none }

class PgDetailsProvider extends ChangeNotifier {
  PgDetailsProvider() {
    lengthCtr.addListener(validateArea);
    widthCtr.addListener(validateArea);
  }

  //---------------------------------------------------
  // form key
  //-----------------------------------------------------

  final GlobalKey<FormState> addressKey = GlobalKey();
  String type = '';
  String propertyType = '';
  String propertyClasses = "";

  // ───────────────────────────────────────────────
  //  CONTROLLERS
  // ───────────────────────────────────────────────
  final pgNameController = TextEditingController();
  final totalFloorsController = TextEditingController();
  final yourFloorCtr = TextEditingController();

  final carpetAreaCtr = TextEditingController();
  final buildAreaCtr = TextEditingController();

  final plotAreaCtr = TextEditingController();
  final lengthCtr = TextEditingController();
  final widthCtr = TextEditingController();
  final widthRoadSideCtr = TextEditingController();

  final rentCtr = TextEditingController();
  final leaseCtr = TextEditingController();
  final rentIncrease = TextEditingController();
  final maintenanceCtrl = TextEditingController();
  final bookingCtrl = TextEditingController();
  final otherCtrl = TextEditingController();

  final fixedCtr = TextEditingController();
  final MultiRentCtr = TextEditingController();

  final mealAmountCtr = TextEditingController();

  final dateCtr = TextEditingController();
  final propertyTypeCtr = TextEditingController();

  final cabinCtr = TextEditingController();
  final meetingRoomCtr = TextEditingController();
  final seatsCtr = TextEditingController();
  final parkingCtr = TextEditingController();
  final customMonthCtr = TextEditingController();
  final TextEditingController descController = TextEditingController();

  // ───────────────────────────────────────────────
  //  STATIC LISTS FROM AppString
  // ───────────────────────────────────────────────
  final List<String> pgForList = AppString.pgForList;
  final List<String> bestSuitedList = AppString.bestSuitedList;
  final List<String> furnishTypeList = AppString.furnishTypeList;
  final List<String> propertyManagedByList = AppString.propertyManagedByList;
  final List<String> yesNoList = AppString.yesNoList;
  final List<String> securityDeposit = AppString.securityDeposit;

  final List<String> roomSharingList = AppString.roomSharingList;
  final List<String> serviceList = AppString.serviceList;
  final List<String> mealTimeList = AppString.mealTimeList;
  final List<String> entryTimeList = AppString.entryTimeList;
  final List<String> commonAreaList = AppString.commonAreaList;

  final List<String> facingList = AppString.facingList;
  final List<String> flooringTypeList = AppString.flooringTypeList;
  final List<String> ageOfProperty = AppString.ageOfProperty;
  final List<String> bhkList = AppString.bhkList;
  final List<String> noOfBathroom = AppString.noOfBathroom;
  final List<String> noOfBalcony = AppString.noOfBalcony;
  final List<String> roomList = AppString.roomList;
  final List<String> measurmentList = AppString.measurmentList;

  final List<String> prefeTenant = AppString.prefeTenant;

  final List<String> constructionStatusList = [
    "Ready to Move",
    "Under Construction",
  ];
  final List<String> expectedTimeList = AppString.expectedTimeList;
  final List<String> propertyConditionList = ["Ready to Use", "Bare Shell"];
  final List<String> locationHubList = AppString.locationHubList;
  final List<String> zoneList = AppString.zoneList;
  final List<String> ownerTypeList = AppString.ownerTypeList;
  final List<String> fire = AppString.fire;
  final List<String> wallStatusList = AppString.wallStatusList;

  final List<String> washroomList = AppString.washroomList;
  final List<String> retailSuitableForList = AppString.retailSuitableForList;

  final List<String> rentTypeList = ["Only Rent", "Only Lease"];
  final List<String> parkingOption = ["Available", "Not Available"];
  final List<String> parkingTypeList = AppString.parkingTypeList;

  final List<String> pantryList = ["Private", "Shared"];
  final List<String> platLandConstructionList =
      AppString.plotLandConstructionList;

  // ───────────────────────────────────────────────
  //  SINGLE VALUE SELECTIONS
  // ───────────────────────────────────────────────
  String? pgFor;
  String? managerStay;
  String? propertyManagedBy;
  String? securityDep;
  String? furnishType;
  String? facing;
  String? flooring;
  String? propertyAge;
  String selectedBhk = "";
  String? bathrooms;
  String? balconies;
  String? constructionStatus;
  String? expectedTime;
  String? propertyCondition;
  String? locationHub;
  String? zoneType;
  String? owner;
  String? wall;
  String? washroom;
  String? privateWashroom;
  String? pubWashroom;
  String? selectedPantry;
  String? pLifts;
  String? sLift;
  String? openSide;
  String? yesOrNo;
  String? plotContr;
  String? lastEntryTime;
  String rentType = "Only Rent";
  String? leaseYear;
  String builtMeasuType = "Sq ft";
  String carpetMeasuType = "Sq ft";
  String plotMeasuType = "Sq ft";
  String facingRoadMeasuType = "Sq ft";
  String mealsAvailable = ""; // Yes / No / Extra fees apply
  String mealType = ""; // Only Veg / Veg & Non Veg

  int coveredParking = 0;
  int openParking = 0;
  int? noticePeriod;

  String lockPerdiod = '';

  bool negotiable = false;
  bool utilitiesIncluded = false;
  bool tax$Free = false;
  bool hideNumber = false;
  bool isBrokerAllow = false;
  bool isHotDeal = false;
  bool isOccCerti = false;
  bool isNOCCerti = false;
  bool boundaryWall = false;
  bool cornerPlot = false;

  // Office specific flags
  bool conferenceRoom = false;
  bool washrooms = false;
  bool furnished = false;
  bool receptionArea = false;
  bool pantry = false;
  bool centralAc = false;
  bool ups = false;
  bool oxygenDuct = false;

  // ───────────────────────────────────────────────
  //  MULTI-SELECTION SETS
  // ───────────────────────────────────────────────
  final Set<String> _bestSuitedFor = {};
  Set<String> get bestSuitedFor => _bestSuitedFor;

  final Set<String> _roomSharing = {};
  Set<String> get roomSharing => _roomSharing;

  final Set<String> _selectedService = {};
  bool isSelectedService(String value) => _selectedService.contains(value);

  Set<String> mealTime = {};
  bool isSelectedMealTime(value) => mealTime.contains(value);

  Set<String> selectedArea = {};
  bool isSelectedArea(value) => selectedArea.contains(value);

  final Set<String> selectedTenant = {};
  bool isSelectedTenant(value) => selectedTenant.contains(value);

  List<String> selectedRoom = [];
  bool isSelectedRoom(value) => selectedRoom.contains(value);

  final Set<String> selectedFire = {};
  bool isSelectedFireM(value) => selectedFire.contains(value);

  final Set<String> retailsSuitable = {};
  bool isSelectedSuitable(value) => retailsSuitable.contains(value);

  List<String> selectedParkingTypes = [];

  // ───────────────────────────────────────────────
  //  ROOM TYPE RELATED MAPS
  // ───────────────────────────────────────────────
  final Map<String, TextEditingController> roomCountCtr = {};
  final Map<String, TextEditingController> roomAmountCtr = {};
  final Map<String, bool> attachedBathroom = {};
  final Map<String, bool> attachedBalcony = {};

  final Map<String, SecurityDepositType> roomSecurityType = {};
  final Map<String, TextEditingController> fixedDepositCtr = {};
  final Map<String, int> multipleOfRent = {};

  void initRoomControllers(List<String> roomSharing) {
    for (var room in roomSharing) {
      fixedDepositCtr.putIfAbsent(room, () => TextEditingController());
      roomAmountCtr.putIfAbsent(room, () => TextEditingController());
    }
  }

  TextEditingController getRoomController(String type) {
    return roomCountCtr.putIfAbsent(type, () => TextEditingController());
  }

  bool getBathroom(String type) => attachedBathroom[type] ?? false;
  bool getBalcony(String type) => attachedBalcony[type] ?? false;

  SecurityDepositType getSecurityType(String room) {
    return roomSecurityType[room] ?? SecurityDepositType.none;
  }

  // ───────────────────────────────────────────────
  //  AMENITIES (using AppString.amenities map)
  // ───────────────────────────────────────────────
  int totalAmenities() {
    return AppString.amenities.values.fold(0, (sum, val) => sum + val);
  }

  int getAmenityCount(String key) {
    return AppString.amenities[key] ?? 0;
  }

  int get minRequiredAmenities {
    if (furnishType == "Fully Furnished") return 6;
    if (furnishType == "Semi Furnished") return 3;
    return 0;
  }

  bool get canOpenFurnishing =>
      furnishType == "Fully Furnished" || furnishType == "Semi Furnished";

  bool get isAmenitiesValid => totalAmenities() >= minRequiredAmenities;

  void inc(String key) {
    updateAmenity(key, 1);
  }

  void dec(String key) {
    updateAmenity(key, -1);
  }

  void updateAmenity(String key, int delta) {
    if (AppString.amenities.containsKey(key)) {
      AppString.amenities[key] = (AppString.amenities[key]! + delta).clamp(
        0,
        99,
      );
      notifyListeners();
    }
  }

  // ───────────────────────────────────────────────
  //  PLOT / AREA VALIDATION
  // ───────────────────────────────────────────────
  String? areaError;

  void validateArea() {
    double plotArea = double.tryParse(plotAreaCtr.text) ?? 0;
    double length = double.tryParse(lengthCtr.text) ?? 0;
    double width = double.tryParse(widthCtr.text) ?? 0;

    if (plotArea == 0) return;

    double enteredArea = length * width;

    if (enteredArea > plotArea) {
      areaError = "Length × Width cannot exceed Plot Area";
    } else {
      areaError = null;
    }

    notifyListeners();
  }

  // ───────────────────────────────────────────────
  //  TOGGLE / SELECTION METHODS
  // ───────────────────────────────────────────────

  void toggleBestSuited(String value) {
    _bestSuitedFor.contains(value)
        ? _bestSuitedFor.remove(value)
        : _bestSuitedFor.add(value);
    notifyListeners();
  }

  bool isSelected(String value) => _bestSuitedFor.contains(value);

  void toggleRoomSharing(String value) {
    if (_roomSharing.contains(value)) {
      _roomSharing.remove(value);
      roomCountCtr[value]?.clear();
      roomAmountCtr.remove(value);
      attachedBathroom.remove(value);
      attachedBalcony.remove(value);
    } else {
      _roomSharing.add(value);
      roomAmountCtr[value] = TextEditingController();
    }
    notifyListeners();
  }

  bool isRoomSharingSelected(String value) => _roomSharing.contains(value);

  void toggleBathroom(String type) {
    attachedBathroom[type] = !(attachedBathroom[type] ?? false);
    notifyListeners();
  }

  void toggleBalcony(String type) {
    attachedBalcony[type] = !(attachedBalcony[type] ?? false);
    notifyListeners();
  }

  void toggleService(String service) {
    if (_selectedService.contains(service)) {
      _selectedService.remove(service);
    } else {
      _selectedService.add(service);
    }
    notifyListeners();
  }

  void setMealsAvailable(String value) {
    mealsAvailable = value;

    if (value == "No") {
      mealType = "";
      mealTime.clear();
      mealAmountCtr.clear();
    }

    notifyListeners();
  }

  void setMealType(String value) {
    mealType = value;
    notifyListeners();
  }

  void setMealTime(String value) {
    if (mealTime.contains(value)) {
      mealTime.remove(value);
    } else {
      mealTime.add(value);
    }
    notifyListeners();
  }

  bool get showMealDetails =>
      mealsAvailable == "Yes" || mealsAvailable == "Extra fees apply";

  void togglePeriod(int value) {
    noticePeriod = value;
    notifyListeners();
  }

  void toggleLockPeriod(String value) {
    lockPerdiod = value;
    notifyListeners();
  }

  void toggleNegotiable(bool value) {
    negotiable = value;
    notifyListeners();
  }

  void toggleutilitiesIncludede(bool value) {
    utilitiesIncluded = value;
    notifyListeners();
  }

  void toggleTax$Free(bool value) {
    tax$Free = value;
    notifyListeners();
  }

  void toggelArea(String value) {
    if (selectedArea.contains(value)) {
      selectedArea.remove(value);
    } else {
      selectedArea.add(value);
    }
    notifyListeners();
  }

  void toggleHideNumber(bool value) {
    hideNumber = value;
    notifyListeners();
  }

  void toggleEntryTime(String value) {
    lastEntryTime = value;
    notifyListeners();
  }

  void selectPgFor(String value) {
    pgFor = value;
    notifyListeners();
  }

  void selectManagerStay(String value) {
    managerStay = value;
    notifyListeners();
  }

  void setPropertyManager(String value) {
    propertyManagedBy = value;
    notifyListeners();
  }

  void incCovered() {
    coveredParking++;
    notifyListeners();
  }

  void decCovered() {
    if (coveredParking > 0) coveredParking--;
    notifyListeners();
  }

  void incOpen() {
    openParking++;
    notifyListeners();
  }

  void decOpen() {
    if (openParking > 0) openParking--;
    notifyListeners();
  }

  void selectSecurityDepo(String value) {
    securityDep = value;
    notifyListeners();
  }

  void setSecurityType(String room, SecurityDepositType type) {
    roomSecurityType[room] = type;

    if (type == SecurityDepositType.fixed) {
      fixedDepositCtr.putIfAbsent(room, () => TextEditingController());
    } else {
      fixedDepositCtr[room]?.clear();
    }

    if (type == SecurityDepositType.multiple) {
      multipleOfRent[room] = multipleOfRent[room] ?? 1;
    }

    notifyListeners();
  }

  void setFurnishType(String value) {
    furnishType = value;
    notifyListeners();
  }

  void setTenant(String value) {
    if (selectedTenant.contains(value)) {
      selectedTenant.remove(value);
    } else {
      selectedTenant.add(value);
    }
    notifyListeners();
  }

  void setFacing(String value) {
    facing = value;
    notifyListeners();
  }

  void setFlooring(String value) {
    flooring = value;
    notifyListeners();
  }

  void setAgeProperty(String value) {
    propertyAge = value;
    notifyListeners();
  }

  void setBHKType(String value) {
    selectedBhk = value;
    notifyListeners();
  }

  void setBathrooms(String value) {
    bathrooms = value;
    notifyListeners();
  }

  void setBalcony(String value) {
    balconies = value;
    notifyListeners();
  }

  void setAdditionalRoom(String value) {
    if (selectedRoom.contains(value)) {
      selectedRoom.remove(value);
    } else {
      selectedRoom.add(value);
    }
    notifyListeners();
  }

  void setBuildArea(String value) {
    builtMeasuType = value;
    notifyListeners();
  }

  void setCarpetArea(String value) {
    carpetMeasuType = value;
    notifyListeners();
  }

  void toggleBroker(bool value) {
    isBrokerAllow = value;
    notifyListeners();
  }

  void setConstructionStatus(String value) {
    constructionStatus = value;
    notifyListeners();
  }

  void setExpectedTime(String value) {
    expectedTime = value;
    notifyListeners();
  }

  void setPropertyCondition(String value) {
    propertyCondition = value;
    notifyListeners();
  }

  void setLocationHub(String value) {
    locationHub = value;
    notifyListeners();
  }

  void setZone(String value) {
    zoneType = value;
    notifyListeners();
  }

  void setOwner(String value) {
    owner = value;
    notifyListeners();
  }

  void setFireMeas(String value) {
    if (selectedFire.contains(value)) {
      selectedFire.remove(value);
    } else {
      selectedFire.add(value);
    }
    notifyListeners();
  }

  void toggleOccCerti(bool value) {
    isOccCerti = value;
    notifyListeners();
  }

  void toggleNocCerti(bool value) {
    isNOCCerti = value;
    notifyListeners();
  }

  void setWall(String value) {
    wall = value;
    notifyListeners();
  }

  void setWashroom(String value) {
    washroom = value;
    notifyListeners();
  }

  void setRetailSuitable(String value) {
    if (retailsSuitable.contains(value)) {
      retailsSuitable.remove(value);
    } else {
      retailsSuitable.add(value);
    }
    notifyListeners();
  }

  void setRentType(String value) {
    rentType = value;
    notifyListeners();
  }

  void setLeaseYear(String value) {
    leaseYear = value;
    notifyListeners();
  }

  void setSecurityDep(String value) {
    securityDep = value;
    notifyListeners();
  }

  void setConferenceRoom(bool value) {
    conferenceRoom = value;
    notifyListeners();
  }

  void setWashrooms(bool value) {
    washrooms = value;
    notifyListeners();
  }

  void setFurnished(bool value) {
    furnished = value;
    notifyListeners();
  }

  void setReceptionArea(bool value) {
    receptionArea = value;
    notifyListeners();
  }

  void setPantry(bool value) {
    pantry = value;
    notifyListeners();
  }

  void setCentralAc(bool value) {
    centralAc = value;
    notifyListeners();
  }

  void setUps(bool value) {
    ups = value;
    notifyListeners();
  }

  void setOxygenDuct(bool value) {
    oxygenDuct = value;
    notifyListeners();
  }

  void setPrivateWashroomr(String value) {
    privateWashroom = value;
    notifyListeners();
  }

  void setPubWashroom(String value) {
    pubWashroom = value;
    notifyListeners();
  }

  void togglePantry(String value) {
    selectedPantry = value;
    notifyListeners();
  }

  void setPLift(String value) {
    pLifts = value;
    notifyListeners();
  }

  void setSLift(String value) {
    sLift = value;
    notifyListeners();
  }

  void setPlotArea(String value) {
    plotMeasuType = value;
    notifyListeners();
  }

  void setWidthRaodSideArea(String value) {
    facingRoadMeasuType = value;
    notifyListeners();
  }

  void setOpenSide(String value) {
    openSide = value;
    notifyListeners();
  }

  void setYesOrNo(String value) {
    yesOrNo = value;
    notifyListeners();
  }

  void setPlotCon(String value) {
    plotContr = value;
    notifyListeners();
  }

  void setBoundaryWall(bool value) {
    ups = value;
    notifyListeners();
  }

  void setCornerPlot(bool value) {
    ups = value;
    notifyListeners();
  }

  void setParkingOption(String value) {
    selectedParkingOption = value;

    if (value == "Not Available") {
      selectedParkingTypes.clear();
    }

    notifyListeners();
  }

  void toggleParkingType(String type) {
    if (selectedParkingTypes.contains(type)) {
      selectedParkingTypes.remove(type);
    } else {
      selectedParkingTypes.add(type);
    }
    notifyListeners();
  }

  String? selectedParkingOption;

  void toggleHotDeal(bool value) {
    isHotDeal = value;
    notifyListeners();
  }

  // ───────────────────────────────────────────────
  //  TOGGLE AMENITY MODEL (unused in provider but kept)
  // ───────────────────────────────────────────────
  void toggleItem(List<AmenityModel> list, int index) {
    list[index].isSelected = !list[index].isSelected;
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

  List<AmenityModel> selectedAmenityModel(List<AmenityModel> list) {
    final selected = list.where((e) => e.isSelected).toList();

    return selected;
  }

  // ------------------------------------------------
  // Address details
  // ------------------------------------------------

  final localityCtr = TextEditingController();
  final addressCtr = TextEditingController();
  final cityCtr = TextEditingController();

  /// city selected or not
  bool get isCitySelected => cityCtr.text.trim().isNotEmpty;

  /// full form validation
  bool get isFormValid =>
      isCitySelected &&
      localityCtr.text.isNotEmpty &&
      addressCtr.text.isNotEmpty;

  // -------------------------------------------------
  // Photo upload
  //--------------------------------------------------

  final ImagePicker _picker = ImagePicker();
  final List<String> images = [];

  /// Pick multiple images
  Future<void> pickImages(BuildContext context) async {
    final List<XFile> pickedImages = await _picker.pickMultiImage(
      imageQuality: 80,
    );

    for (var image in pickedImages) {
      final file = File(image.path);
      final sizeInMB = file.lengthSync() / (1024 * 1024);

      if (sizeInMB <= 2) {
        images.add(image.path);
      } else {
        AppSnackBar.error(context, "Image size should be less than 2 MB");
      }
    }

    notifyListeners();
  }

  void removeImage(int index) {
    images.removeAt(index);
    notifyListeners();
  }

  Future<void> uploadImages({required String propertyId}) async {
    try {
      final response = await _repo.uploadPgImages(
        propertyId: propertyId,
        images: images,
      );

      debugPrint("Image upload success: ${response.data}");
    } catch (e) {
      debugPrint("Image upload error: $e");
      rethrow;
    } finally {}
  }

  // ───────────────────────────────────────────────
  //  RESET / CLEAR ALL DATA
  // ───────────────────────────────────────────────

  /// Resets all form fields, selections, counters, maps, sets, controllers' text
  /// Use this when user wants to start a fresh property postin
  ///
  void clearAllData() {
    // ── Text Controllers ───────────────────────────────────────
    for (final controller in [
      pgNameController,
      totalFloorsController,
      yourFloorCtr,
      carpetAreaCtr,
      buildAreaCtr,
      plotAreaCtr,
      lengthCtr,
      widthCtr,
      widthRoadSideCtr,
      rentCtr,
      leaseCtr,
      maintenanceCtrl,
      bookingCtrl,
      otherCtrl,
      fixedCtr,
      MultiRentCtr,
      mealAmountCtr,
      dateCtr,
      propertyTypeCtr,
      cabinCtr,
      meetingRoomCtr,
      seatsCtr,
      parkingCtr,
    ]) {
      controller.clear();
    }

    // Clear room-specific controllers
    for (final controller in roomCountCtr.values) {
      controller.clear();
    }
    for (final controller in roomAmountCtr.values) {
      controller.clear();
    }
    for (final controller in fixedDepositCtr.values) {
      controller.clear();
    }

    // ── Single selections ──────────────────────────────────────
    pgFor = null;
    managerStay = null;
    propertyManagedBy = null;
    securityDep = null;
    furnishType = null;
    facing = null;
    flooring = null;
    propertyAge = null;
    selectedBhk = "";
    bathrooms = null;
    balconies = null;
    constructionStatus = null;
    expectedTime = null;
    propertyCondition = null;
    locationHub = null;
    zoneType = null;
    owner = null;
    wall = null;
    washroom = null;
    privateWashroom = null;
    pubWashroom = null;
    selectedPantry = null;
    pLifts = null;
    sLift = null;
    openSide = null;
    yesOrNo = null;
    plotContr = null;
    lastEntryTime = null;
    rentType = "Only Rent";
    leaseYear = null;
    builtMeasuType = "Sq ft";
    carpetMeasuType = "Sq ft";
    plotMeasuType = "Sq ft";
    facingRoadMeasuType = "Sq ft";
    mealsAvailable = "";
    mealType = "";

    // ── Counters & numbers ─────────────────────────────────────
    coveredParking = 0;
    openParking = 0;
    noticePeriod = null;

    // ── Booleans ───────────────────────────────────────────────
    negotiable = false;
    utilitiesIncluded = false;
    hideNumber = false;
    isBrokerAllow = false;
    isHotDeal = false;
    isOccCerti = false;
    isNOCCerti = false;
    boundaryWall = false;
    cornerPlot = false;

    conferenceRoom = false;
    washrooms = false;
    furnished = false;
    receptionArea = false;
    pantry = false;
    centralAc = false;
    ups = false;
    oxygenDuct = false;

    // ── Strings ────────────────────────────────────────────────
    lockPerdiod = '';

    // ── Collections ────────────────────────────────────────────
    _bestSuitedFor.clear();
    _roomSharing.clear();
    _selectedService.clear();
    mealTime.clear();
    selectedArea.clear();
    selectedTenant.clear();
    selectedRoom.clear();
    selectedFire.clear();
    retailsSuitable.clear();
    selectedParkingTypes.clear();
    images.clear();

    // ── Maps ───────────────────────────────────────────────────
    roomSecurityType.clear();
    multipleOfRent.clear();

    // Clear amenity counters in AppString (if you want full reset)
    AppString.amenities.updateAll((key, value) => 0);

    // ── Error states ───────────────────────────────────────────
    areaError = null;

    // Important: notify UI
    notifyListeners();
  }

  // ───────────────────────────────────────────────
  //  IMPROVED DISPOSE – clear text + dispose all controllers
  // ───────────────────────────────────────────────
  @override
  void dispose() {
    // Dispose ALL controllers we have
    final allControllers = <TextEditingController>[
      pgNameController,
      totalFloorsController,
      yourFloorCtr,
      carpetAreaCtr,
      buildAreaCtr,
      plotAreaCtr,
      lengthCtr,
      widthCtr,
      widthRoadSideCtr,
      rentCtr,
      leaseCtr,
      maintenanceCtrl,
      bookingCtrl,
      otherCtrl,
      fixedCtr,
      MultiRentCtr,
      mealAmountCtr,
      dateCtr,
      propertyTypeCtr,
      cabinCtr,
      meetingRoomCtr,
      seatsCtr,
      parkingCtr,
      ...roomCountCtr.values,
      ...roomAmountCtr.values,
      ...fixedDepositCtr.values,
    ];

    for (final controller in allControllers) {
      controller.dispose();
    }

    // Optional: also clear data (but usually not needed in dispose)
    // clearAllData();   // ← uncomment only if you want full reset on dispose

    super.dispose();
  }

  // ───────────────────────────────────────────────
  //  API CALL (kept exactly as original)
  // ───────────────────────────────────────────────
  final _repo = PostPropertyRepo();

  Future<void> postProperty() async {
    try {
      final User? userData = await LocalStorageService.getUser();
      String phone = userData?.phone ?? '';
      final model = RentSellReqModel(
        listingType: type.toUpperCase(),
        propertyType: propertyClasses.toUpperCase(),
        propertyCategory: propertyType,

        residentialDetails: ResidentialDetails(
          ageOfProperty: propertyAge,
          bhkType: selectedBhk,
          bathrooms: bathrooms,
          balconies: balconies,
          additionalRooms: selectedRoom,

          furnishing: Furnishing(
            type: furnishType,
            amenities: AppString.amenities.entries.map((e) {
              return Amenity(name: e.key, quantity: e.value);
            }).toList(),
          ),

          facing: facing,
          flooring: flooring,

          area: Area(
            builtUp: BuiltUp(
              value: int.tryParse(buildAreaCtr.text),
              unit: builtMeasuType,
            ),
            carpet: BuiltUp(
              value: int.tryParse(carpetAreaCtr.text),
              unit: carpetMeasuType,
            ),
          ),

          parking: Parking(
            parkingDetails: [
              ParkingDetail(label: "Covered", value: coveredParking),
              ParkingDetail(label: "Open", value: openParking),
            ],
          ),

          totalFloors: int.tryParse(totalFloorsController.text),
          yourFloor: int.tryParse(yourFloorCtr.text),

          preferredTenants: selectedTenant.toList(),
          availableFrom: DateTime.tryParse(dateCtr.text),

          isBroker: isBrokerAllow,
        ),

        pricing: Pricing(
          rent: Rent(
            pricingRoomtype: rentType,
            rentAmount: int.tryParse(rentCtr.text),
            isElectricity: utilitiesIncluded,
            isNegotiable: negotiable,
            leaseAmount: int.tryParse(leaseCtr.text),
            numberOfYearLease: leaseYear,
            istaxAndGov: tax$Free,
            yearlyRentIncreaseByPercent: int.tryParse(rentIncrease.text),
          ),

          securityDeposit: SecurityDeposit(
            label: securityDep,
            amount: int.tryParse(fixedCtr.text),
          ),

          noticePeriod: noticePeriod,

          lockInPeriod: LockInPeriod(
            month: int.tryParse(customMonthCtr.text),
            lable: lockPerdiod,
          ),
        ),

        location: Location(
          city: cityCtr.text, // replace with your controller
          locality: localityCtr.text,
          society: addressCtr.text,
        ),

        contact: Contact(
          phone: phone,
          phonePrivate: hideNumber,
          amenities: selectedAmenityTitles,
          preferences: selectedRulesTitles,
        ),

        images: [],

        description: descController.text,
      );

      final res = await _repo.postProperty(model);

      String propertyId = res['data'];

      await uploadImages(propertyId: propertyId);

      //  print("Success ====> $");
    } catch (e) {
      print("Post property error: $e");
    }
  }

  // ------------------------------------------
  // PG API
  //------------------------------------------

  Future<void> pgPost() async {
    // Optional: show loading
    // showLoadingOverlay(context, message: "Posting your PG...");

    try {
      final User? userData = await LocalStorageService.getUser();
      String phone = userData?.phone ?? '';
      // ── Build RoomTypes list (this was the biggest missing part) ─────────────
      List<RoomType> roomTypesList = [];

      for (String sharing in _roomSharing) {
        final countText = roomCountCtr[sharing]?.text.trim() ?? '0';
        final amountText = roomAmountCtr[sharing]?.text.trim() ?? '0';

        final rooms = int.tryParse(countText) ?? 0;
        final rent = int.tryParse(amountText) ?? 0;

        SecurityDepositType? secDepositTypeStr = getSecurityType(sharing);
        TextEditingController? fixedAmount = fixedDepositCtr[sharing];
        String? type;
        if (secDepositTypeStr == SecurityDepositType.fixed) {
          type = "Fixed";
        } else if (secDepositTypeStr == SecurityDepositType.multiple) {
          type = "Multiple of rent";
        } else {
          type = "None";
        }

        roomTypesList.add(
          RoomType(
            sharingType: sharing,
            roomsAvailable: rooms,
            rentAmount: rent,
            securityDepositType: type,
            amount: int.tryParse(fixedAmount?.text.trim() ?? '0'),
            attachedBathroom: attachedBathroom[sharing] ?? false,
            attachedBalcony: attachedBalcony[sharing] ?? false,
          ),
        );
      }

      // ── Build Parking ────────────────────────────────────────────────────────
      final parkingObj = PGParking(covered: coveredParking, open: openParking);

      // ── Build Pricing (example – adjust according to your real needs) ────────
      final pricingObj = PGPricing(
        addMore: AddMore(
          maintenanceCharge: int.tryParse(maintenanceCtrl.text),
          bookingAmount: int.tryParse(bookingCtrl.text),
          otherCharge: int.tryParse(otherCtrl.text),
        ), // fill if you have extra charges
        rent: PGRent(
          isElectricity: utilitiesIncluded,
          isNegotiable: negotiable,
        ),
        mealsAvailable: mealsAvailable.isNotEmpty ? mealsAvailable : null,
        mealsType: mealType.isNotEmpty ? mealType : null,
        mealsAvailableOnWeekdays: mealTime
            .toList(), // fill from mealTime if weekend
        mealsAmount: int.tryParse(mealAmountCtr.text) ?? 0,
        noticePeriod: noticePeriod,
        lockInPeriod: LockInPeriod(
          month: int.tryParse(customMonthCtr.text),
          lable: lockPerdiod,
        ),
      );

      // ── Build Location (from your address fields) ────────────────────────────
      final locationObj = Location(
        society: addressCtr.text.trim(),
        locality: localityCtr.text.trim(),
        city: cityCtr.text.trim(),
        // add lat/long, pincode, society if you have
      );

      // ── Build Contact ────────────────────────────────────────────────────────
      final contactObj = PGContact(
        phone: phone, // ← replace with real phone (from auth?)
        phonePrivate: hideNumber,
        amenities: selectedAmenityTitles, // common areas
        pgRules: selectedRulesTitles, // if you have pg rules set
        lastEntryTime: lastEntryTime,
        commonArea: selectedArea.toList(),
      );

      // ── Images (assuming List<String> urls or paths) ─────────────────────────

      // ── Create model ─────────────────────────────────────────────────────────
      final model = PgReqModel(
        listingType: "PG",
        pgDetails: PgDetails(
          pgName: pgNameController.text.trim(),
          pgFor: pgFor,
          bestSuitedFor: bestSuitedFor.toList(),
          totalFloors: int.tryParse(totalFloorsController.text.trim()),
          roomTypes: roomTypesList, // ← fixed here
          furnishing: Furnishing(
            type: furnishType,
            amenities: AppString.amenities.entries
                .where((e) => e.value > 0)
                .map((e) => Amenity(name: e.key, quantity: e.value))
                .toList(),
          ),
          parking: parkingObj,
          managedBy: propertyManagedBy,
          managerStaysAtPg: managerStay == "Yes", // assuming yesNoList
          availableFrom: dateCtr.text,
          includedServices: _selectedService.toList(),
        ),
        pricing: pricingObj,
        location: locationObj,
        contact: contactObj,
        description: descController.text
            .trim(), // or your description controller
      );

      print(model.toJson());

      // ── Call API ─────────────────────────────────────────────────────────────
      final res = await _repo.pgPostProperty(model);

      String propertyId = res['data'];

      await uploadImages(propertyId: propertyId);

      // Success
      // hideLoadingOverlay(context);
      // AppSnackBar.success(context, "PG posted successfully!");
      // Navigator.pop(context); or clear form
    } catch (e, stack) {
      // hideLoadingOverlay(context);
      // AppSnackBar.error(context, "Failed to post PG: ${e.toString()}");
      debugPrint("Post PG error: $e\n$stack");
    }
  }
}

// ───────────────────────────────────────────────
//  AmenityModel & sample lists (kept outside class)
// ───────────────────────────────────────────────

class AmenityModel {
  final String title;
  final String icon; // asset path
  bool isSelected;

  AmenityModel({
    required this.title,
    required this.icon,
    this.isSelected = false,
  });
}

List<AmenityModel> amenitiesList = [
  AmenityModel(title: "Lift", icon: "assets/icons/lift.png"),
  AmenityModel(title: "Power Backup", icon: "assets/icons/power.png"),
  AmenityModel(title: "Gym", icon: "assets/icons/gym.png"),
  AmenityModel(title: "Swimming Pool", icon: "assets/icons/pool.png"),
  AmenityModel(title: "CCTV Surveillance", icon: "assets/icons/cctv.png"),
  AmenityModel(title: "Gated Community", icon: "assets/icons/gated.png"),
  AmenityModel(title: "Water Supply", icon: "assets/icons/water.png"),
  AmenityModel(title: "Parking Lot", icon: "assets/icons/parking.png"),
  AmenityModel(title: "Kids Area", icon: "assets/icons/kids.png"),
  AmenityModel(title: "Playground", icon: "assets/icons/playground.png"),
  AmenityModel(title: "Community Garden", icon: "assets/icons/garden.png"),
  AmenityModel(title: "Free Wifi", icon: "assets/icons/wifi.png"),
  AmenityModel(title: "Club", icon: "assets/icons/club.png"),
  AmenityModel(title: "Gas", icon: "assets/icons/gas.png"),
  AmenityModel(title: "Sewage", icon: "assets/icons/sewage.png"),
];

List<AmenityModel> preferencesList = [
  AmenityModel(title: "Bachelor", icon: "assets/icons/lift.png"),
  AmenityModel(title: "Family", icon: "assets/icons/power.png"),
  AmenityModel(title: "Living Couple", icon: "assets/icons/gym.png"),
  AmenityModel(title: "Professional", icon: "assets/icons/pool.png"),
  AmenityModel(title: "No Pets", icon: "assets/icons/cctv.png"),
  AmenityModel(title: "No Smoking", icon: "assets/icons/gated.png"),
  AmenityModel(title: "Student", icon: "assets/icons/water.png"),
  AmenityModel(title: "Guests are allowed", icon: "assets/icons/parking.png"),
  AmenityModel(title: "Only Veg", icon: "assets/icons/gated.png"),
  AmenityModel(title: "Gender Restrictions", icon: "assets/icons/water.png"),
  AmenityModel(title: "No Alcohol", icon: "assets/icons/parking.png"),
];
