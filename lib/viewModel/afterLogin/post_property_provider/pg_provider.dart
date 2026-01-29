import 'package:flutter/material.dart';
import 'package:token_app/model/response_model/post_property_model/rent_sell_res_model.dart';
import 'package:token_app/repository/post_property_repo.dart';
import 'package:token_app/resources/App_string.dart';

enum SecurityDepositType { fixed, multiple, none }

class PgDetailsProvider extends ChangeNotifier {
  // ---------------- CONTROLLERS ----------------
  final pgNameController = TextEditingController();
  final floorsController = TextEditingController();
  final dataCtr = TextEditingController();

  // ---------------- STATIC LISTS ----------------
  final List<String> pgForList = AppString.pgForList;
  final List<String> bestSuitedList = AppString.bestSuitedList;
  final List<String> furnishTypeList = AppString.furnishTypeList;
  final List<String> propertyManagedByList = AppString.propertyManagedByList;
  final List<String> yesNoList = AppString.yesNoList;

  final List<String> securityDeposit = AppString.securityDeposit;

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

  final List<String> roomSharingList = AppString.roomSharingList;

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
    return AppString.amenities.values.fold(0, (sum, val) => sum + val);
  }

  int getAmenityCount(String key) {
    return AppString.amenities[key] ?? 0;
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
    if (AppString.amenities.containsKey(key)) {
      AppString.amenities[key] = (AppString.amenities[key]! + delta).clamp(
        0,
        99,
      );
      notifyListeners();
    }
  }
  // pricing

  final List<String> serviceList = AppString.serviceList;

  final Set<String> _selectedService = {};

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

  Set<String> mealTime = {};

  List<String> mealTimeList = AppString.mealTimeList;

  bool isSelectedMealTime(value) => mealTime.contains(value);

  final TextEditingController mealAmountCtr = TextEditingController();

  /// ---------------- SETTERS ----------------
  void setMealsAvailable(String value) {
    mealsAvailable = value;

    // Reset dependent fields if "No"
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

  /// ---------------- HELPERS ----------------
  bool get showMealDetails =>
      mealsAvailable == "Yes" || mealsAvailable == "Extra fees apply";

  // noticed periods

  int? noticePeriod;

  void togglePeriod(int value) {
    noticePeriod = value;
    notifyListeners();
  }

  // Lock in Period

  String LockPerdiod = '';

  void toggleLockPeriod(String value) {
    LockPerdiod = value;
    notifyListeners();
  }

  // add More pricing Details

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

  // Contact & Amenties For Pg

  final List<String> entryTimeList = AppString.entryTimeList;

  final List<String> commonAreaList = AppString.commonAreaList;

  Set<String> selectedArea = {};

  bool isSelectedArea(value) => selectedArea.contains(value);

  void toggelArea(String value) {
    if (selectedArea.contains(value)) {
      selectedArea.remove(value);
    } else {
      selectedArea.add(value);
    }
    notifyListeners();
  }

  bool hideNumber = false;

  void toggleHideNumber(bool value) {
    hideNumber = value;
    notifyListeners();
  }

  String? lastEntryTime;

  void toggleEntryTime(String value) {
    lastEntryTime = value;
    notifyListeners();
  }

  /// toggle selection
  void toggleItem(List<AmenityModel> list, int index) {
    list[index].isSelected = !list[index].isSelected;
    notifyListeners();
  }

  List<AmenityModel> selectedAmenityModel(List<AmenityModel> list) {
    final selected = list.where((e) => e.isSelected).toList();

    return selected;
  }

  /// Rent and sale page
  ///
  final TextEditingController dateCtr = TextEditingController();
  final TextEditingController propertyTypeCtr = TextEditingController();

  final Set<String> selectedTenant = {};

  bool isSelectedTenant(value) => selectedTenant.contains(value);

  void setTenant(String value) {
    if (selectedTenant.contains(value)) {
      selectedTenant.remove(value);
    } else {
      selectedTenant.add(value);
    }
    notifyListeners();
  }

  final List<String> prefeTenant = AppString.prefeTenant;

  // === facing -======

  String? facing;

  final List<String> facingList = AppString.facingList;
  void setFacing(String value) {
    facing = value;
    notifyListeners();
  }

  // Floaring type ''''''

  String? flooring;
  void setFlooring(String value) {
    flooring = value;
    notifyListeners();
  }

  final List<String> flooringTypeList = AppString.flooringTypeList;

  // age of property

  String? propertyAge;
  final List<String> ageOfProperty = AppString.ageOfProperty;

  void setAgeProperty(String value) {
    propertyAge = value;
    notifyListeners();
  }

  // BHK type

  final List<String> bhkList = AppString.bhkList;

  String selectedBhk = "";
  void setBHKType(String value) {
    selectedBhk = value;
    notifyListeners();
  }

  // Bathrooms

  String? bathrooms;
  final List<String> noOfBathroom = AppString.noOfBathroom;

  void setBathrooms(String value) {
    bathrooms = value;
    notifyListeners();
  }

  // Balconies

  String? balconies;
  final List<String> noOfBalcony = AppString.noOfBalcony;

  void setBalcony(String value) {
    balconies = value;
    notifyListeners();
  }

  // Additional Room

  final List<String> roomList = AppString.roomList;

  List<String> selectedRoom = [];

  bool isSelectedRoom(value) => selectedRoom.contains(value);

  void setAdditionalRoom(String value) {
    if (selectedRoom.contains(value)) {
      selectedRoom.remove(value);
    } else {
      selectedRoom.add(value);
    }
    notifyListeners();
  }

  // Area detail

  final carpetAreaCtr = TextEditingController();
  final buildAreaCtr = TextEditingController();

  final List<String> measurmentList = AppString.measurmentList;

  String builtMeasuType = "Sq ft";
  String carpetMeasuType = "Sq ft";

  void setBuildArea(String value) {
    builtMeasuType = value;
    notifyListeners();
  }

  void setCarpetArea(String value) {
    carpetMeasuType = value;
    notifyListeners();
  }

  bool isBrokerAllow = false;

  void toggleBroker(bool value) {
    isBrokerAllow = value;
    notifyListeners();
  }

  // Rent and sale

  // Construction status
  final List<String> constructionStatusList = [
    "Ready to Move",
    "Under Construction",
  ];

  String? constructionStatus;

  void setConstructionStatus(String value) {
    constructionStatus = value;
    notifyListeners();
  }

  // under construction - expected time

  String? expectedTime;

  void setExpectedTime(String value) {
    expectedTime = value;
    notifyListeners();
  }

  final List<String> expectedTimeList = AppString.expectedTimeList;

  // property condition
  final List<String> propertyConditionList = ["Ready to Use", "Bare Shell"];

  String? propertyCondition;

  void setPropertyCondition(String value) {
    propertyCondition = value;
    notifyListeners();
  }

  //Location Hub

  String? locationHub;

  void setLocationHub(String value) {
    locationHub = value;
    notifyListeners();
  }

  final List<String> locationHubList = AppString.locationHubList;

  // Zone type

  String? zoneType;

  void setZone(String value) {
    zoneType = value;
    notifyListeners();
  }

  final List<String> zoneList = AppString.zoneList;
  // owner

  String? owner;

  void setOwner(String value) {
    owner = value;
    notifyListeners();
  }

  final List<String> ownerTypeList = AppString.ownerTypeList;

  // fire safty measurment

  final Set<String> selectedFire = {};

  bool isSelectedFireM(value) => selectedFire.contains(value);

  void setFireMeas(String value) {
    if (selectedFire.contains(value)) {
      selectedFire.remove(value);
    } else {
      selectedFire.add(value);
    }
    notifyListeners();
  }

  final List<String> fire = AppString.fire;

  // other infor

  bool isOccCerti = false;

  void toggleOccCerti(bool value) {
    isOccCerti = value;
    notifyListeners();
  }

  bool isNOCCerti = false;

  void toggleNocCerti(bool value) {
    isNOCCerti = value;
    notifyListeners();
  }

  // wall Status

  String? wall;

  void setWall(String value) {
    wall = value;
    notifyListeners();
  }

  final List<String> wallStatusList = AppString.wallStatusList;

  // ============================ Retail Shop section========================
  //
  //

  // Washroom ===

  String? washroom;

  void setWashroom(String value) {
    washroom = value;
    notifyListeners();
  }

  final List<String> washroomList = AppString.washroomList;

  // Suitable for ratil shop

  final List<String> retailSuitableForList = AppString.retailSuitableForList;

  final Set<String> retailsSuitable = {};

  bool isSelectedSuitable(value) => retailsSuitable.contains(value);

  void setRetailSuitable(String value) {
    if (retailsSuitable.contains(value)) {
      retailsSuitable.remove(value);
    } else {
      retailsSuitable.add(value);
    }
    notifyListeners();
  }

  /// Rent - resident - pricing page

  // ================

  final rentCtr = TextEditingController();
  final leaseCtr = TextEditingController();
  final maintenanceCtrl = TextEditingController();
  final bookingCtrl = TextEditingController();
  final otherCtrl = TextEditingController();

  // you'r going to =============

  final List<String> rentTypeList = ["Only Rent", "Only Lease"];

  String rentType = "Only Rent";
  void setRentType(String value) {
    rentType = value;
    notifyListeners();
  }

  String? leaseYear;
  void setLeaseYear(String value) {
    leaseYear = value;
    notifyListeners();
  }

  // secutiry deposit

  final fixedCtr = TextEditingController();
  final MultiRentCtr = TextEditingController();

  void setSecurityDep(String value) {
    securityDep = value;
    notifyListeners();
  }

  // ============ Office layout =================

  final cabinCtr = TextEditingController();
  final meetingRoomCtr = TextEditingController();
  final seatsCtr = TextEditingController();

  bool conferenceRoom = false;
  bool washrooms = false;
  bool furnished = false;
  bool receptionArea = false;
  bool pantry = false;
  bool centralAc = false;
  bool ups = false;
  bool oxygenDuct = false;

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

  // Private washroom

  String? privateWashroom;
  void setPrivateWashroomr(String value) {
    privateWashroom = value;
    notifyListeners();
  }

  // Public washroom

  String? pubWashroom;
  void setPubWashroom(String value) {
    pubWashroom = value;
    notifyListeners();
  }

  // pantry list

  final List<String> pantryList = ["Private", "Shared"];
  String? selectedPantry;
  void togglePantry(String value) {
    selectedPantry = value;
    notifyListeners();
  }

  // Lift section =========================

  String? pLifts;
  void setPLift(String value) {
    pLifts = value;
    notifyListeners();
  }

  String? sLift;
  void setSLift(String value) {
    sLift = value;
    notifyListeners();
  }

  // plot and land

  String? openSide;
  void setOpenSide(String value) {
    openSide = value;
    notifyListeners();
  }

  String? yesOrNo;

  void setYesOrNo(String value) {
    yesOrNo = value;
    notifyListeners();
  }

  String? plotContr;

  final List<String> platLandConstructionList =
      AppString.plotLandConstructionList;

  void setPlotCon(String value) {
    plotContr = value;
    notifyListeners();
  }

  bool boundaryWall = false;
  bool cornerPlot = false;

  void setBoundaryWall(bool value) {
    ups = value;
    notifyListeners();
  }

  void setCornerPlot(bool value) {
    ups = value;
    notifyListeners();
  }

  // Parking type

  final parkingCtr = TextEditingController();
  final List<String> parkingOption = ["Available", "Not Available"];

  final List<String> parkingTypeList = AppString.parkingTypeList;
  String? selectedParkingOption;
  List<String> selectedParkingTypes = [];

  void setParkingOption(String value) {
    selectedParkingOption = value;

    // clear types if Not Available
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

  // sell section -resident --Apartment

  bool isHotDeal = false;

  void toggleHotDeal(bool value) {
    isHotDeal = value;
    notifyListeners();
  }

  // ==================Api implemented rent and sell residentional===============

  final _repo = PostPropertyRepo();

  Future<void> postProperty() async {
    try {
      final model = RentSellResModel(
        listingType: "Rent",
        propertyType: "Residential",
        propertyCategory: "Apartment",

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

          totalFloors: int.tryParse(floorsController.text),
          yourFloor: int.tryParse(dataCtr.text),

          preferredTenants: selectedTenant.toList(),
          availableFrom: DateTime.tryParse(dateCtr.text),

          isBroker: isBrokerAllow,
        ),

        pricing: Pricing(
          rent: Rent(
            label: rentType,
            rantAmount: int.tryParse(rentCtr.text),
            isElectricity: utilitiesIncluded,
            isNegotiable: negotiable,
          ),

          amenities: _selectedService.map((e) {
            return SecurityDeposit(label: e, amount: 0);
          }).toList(),

          securityDeposit: SecurityDeposit(
            label: securityDep,
            amount: int.tryParse(fixedCtr.text),
          ),

          noticePeriod: noticePeriod,

          lockInPeriod: LockInPeriod(
            label: LockPerdiod,
            month: int.tryParse(leaseYear ?? "0"),
          ),
        ),

        location: Location(
          city: "Delhi", // replace with your controller
          locality: "Noida",
          society: "My Society",
        ),

        contact: Contact(phone: "6397892585", phonePrivate: hideNumber),

        amenities: selectedArea.toList(),

        preferences: selectedTenant.toList(),

        images: [],

        description: dataCtr.text,
      );

      await _repo.postProperty(model);

      //  print("Success ====> $");
    } catch (e) {
      print("Post property error: $e");
    }
  }
}

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
