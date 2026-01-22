import 'package:flutter/material.dart';

enum SecurityDepositType { fixed, multiple, none }

class PgDetailsProvider extends ChangeNotifier {
  // ---------------- CONTROLLERS ----------------
  final pgNameController = TextEditingController();
  final floorsController = TextEditingController();
  final dataCtr = TextEditingController();

  // ---------------- STATIC LISTS ----------------
  final List<String> pgForList = ["Male", "Female", "All"];
  final List<String> bestSuitedList = [
    "Working",
    "Student",
    "Business",
    "Other",
  ];
  final List<String> furnishTypeList = [
    "Fully Furnished",
    "Semi Furnished",
    "Unfurnished",
  ];
  final List<String> propertyManagedByList = ["Owner", "Agent", "Company"];
  final List<String> yesNoList = ["Yes", "No"];

  final List<String> securityDeposit = ["Fixed", "Multiple of Rent", "None"];

  // ---------------- SELECTIONS ----------------
  String? pgFor;
  String? managerStay;

  String? propertyManagedBy;

  String? securityDep;

  int coveredParking = 0;
  int openParking = 0;

  // ---------------- MULTI SELECT ----------------
  final Set<String> _bestSuitedFor = {};

  Set<String> get bestSuitedFor => _bestSuitedFor;

  void toggleBestSuited(String value) {
    _bestSuitedFor.contains(value)
        ? _bestSuitedFor.remove(value)
        : _bestSuitedFor.add(value);
    notifyListeners();
  }

  bool isSelected(String value) => _bestSuitedFor.contains(value);

  final List<String> roomSharingList = ["Private", "Twin", "Triple", "Quad"];

  final Set<String> _roomSharing = {};
  Set<String> get roomSharing => _roomSharing;

  final Map<String, TextEditingController> roomAmountCtr = {};

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

  // ---------------- ROOM DATA PER TYPE ----------------
  final Map<String, TextEditingController> roomCountCtr = {};
  final Map<String, bool> attachedBathroom = {};
  final Map<String, bool> attachedBalcony = {};

  TextEditingController getRoomController(String type) {
    return roomCountCtr.putIfAbsent(type, () => TextEditingController());
  }

  bool getBathroom(String type) => attachedBathroom[type] ?? false;
  bool getBalcony(String type) => attachedBalcony[type] ?? false;

  void toggleBathroom(String type) {
    attachedBathroom[type] = !(attachedBathroom[type] ?? false);
    notifyListeners();
  }

  void toggleBalcony(String type) {
    attachedBalcony[type] = !(attachedBalcony[type] ?? false);
    notifyListeners();
  }

  // ---------------- SINGLE SELECT ----------------
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

  @override
  void dispose() {
    pgNameController.dispose();
    floorsController.dispose();
    dataCtr.dispose();

    for (final controller in roomCountCtr.values) {
      controller.dispose();
    }

    super.dispose();
  }

  String? furnishType;

  final Map<String, SecurityDepositType> roomSecurityType = {};
  final Map<String, TextEditingController> fixedDepositCtr = {};
  final Map<String, int> multipleOfRent = {};

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

  SecurityDepositType getSecurityType(String room) {
    return roomSecurityType[room] ?? SecurityDepositType.none;
  }

  // ----- SET FURNISH TYPE -----
  void setFurnishType(String value) {
    furnishType = value;
    notifyListeners();
  }

  // ----- TOTAL SELECTED AMENITIES -----
  int totalAmenities() {
    return amenities.values.fold(0, (sum, val) => sum + val);
  }

  int getAmenityCount(String key) {
    return amenities[key] ?? 0;
  }

  // ----- MIN REQUIRED BASED ON TYPE -----
  int get minRequiredAmenities {
    if (furnishType == "Fully Furnished") return 6;
    if (furnishType == "Semi Furnished") return 3;
    return 0;
  }

  bool get canOpenFurnishing =>
      furnishType == "Fully Furnished" || furnishType == "Semi Furnished";

  bool get isAmenitiesValid => totalAmenities() >= minRequiredAmenities;

  // ----- COUNTER HANDLERS -----
  void inc(String key) {
    updateAmenity(key, 1);
  }

  void dec(String key) {
    updateAmenity(key, -1);
  }

  void updateAmenity(String key, int delta) {
    if (amenities.containsKey(key)) {
      amenities[key] = (amenities[key]! + delta).clamp(0, 99);
      notifyListeners();
    }
  }

  Map<String, int> amenities = {
    "fan": 0,
    "ac": 0,
    "tv": 0,
    "bed": 0,
    "wardrobe": 0,
    "geyser": 0,
    "sofa": 0,
    "washingMachine": 0,
    "stove": 0,
    "fridge": 0,
    "waterPurifier": 0,
    "microwave": 0,
    "modularKitchen": 0,
    "chimney": 0,
    "diningTable": 0,
    "curtains": 0,
    "exhaustFan": 0,
    "lights": 0,
  };

  final amenityList = [
    {"name": "Fans", "key": "fan"},
    {"name": "AC", "key": "ac"},
    {"name": "TV", "key": "tv"},
    {"name": "Beds", "key": "bed"},
    {"name": "Wardrobe", "key": "wardrobe"},
    {"name": "Geysers", "key": "geyser"},
    {"name": "Sofa", "key": "sofa"},
    {"name": "Washing Machine", "key": "washingMachine"},
    {"name": "Stove", "key": "stove"},
    {"name": "Fridge", "key": "fridge"},
    {"name": "Water Purifier", "key": "waterPurifier"},
    {"name": "Microwave", "key": "microwave"},
    {"name": "Modular Kitchen", "key": "modularKitchen"},
    {"name": "Chimney", "key": "chimney"},
    {"name": "Dining Table", "key": "diningTable"},
    {"name": "Curtains", "key": "curtains"},
    {"name": "Exhaust Fan", "key": "exhaustFan"},
    {"name": "Lights", "key": "lights"},
  ];

  // pricing

  final List<String> serviceList = [
    "Water Charges",
    "Laundry",
    "Wifi",
    "House Keeping",
    "Maintenance",
    "Cooking Gas",
    "Trash Removal",
    "DTH",
  ];

  Set<String> _selectedService = {};

  bool isSelectedService(String value) => _selectedService.contains(value);

  void toggleService(String service) {
    if (_selectedService.contains(service)) {
      _selectedService.remove(service);
    } else {
      _selectedService.add(service);
    }
    notifyListeners();
  }

  String mealsAvailable = ""; // Yes / No / Extra fees apply
  String mealType = ""; // Only Veg / Veg & Non Veg
  String mealTime = ""; // Breakfast / Lunch / Dinner

  final TextEditingController mealAmountCtr = TextEditingController();

  /// ---------------- SETTERS ----------------
  void setMealsAvailable(String value) {
    mealsAvailable = value;

    // Reset dependent fields if "No"
    if (value == "No") {
      mealType = "";
      mealTime = "";
      mealAmountCtr.clear();
    }

    notifyListeners();
  }

  void setMealType(String value) {
    mealType = value;
    notifyListeners();
  }

  void setMealTime(String value) {
    mealTime = value;
    notifyListeners();
  }

  /// ---------------- HELPERS ----------------
  bool get showMealDetails =>
      mealsAvailable == "Yes" || mealsAvailable == "Extra fees apply";
}
