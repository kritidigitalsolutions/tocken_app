import 'package:token_app/model/request_model/post_property/common_property_req_model.dart';

class RentSellReqModel {
  RentSellReqModel({
    required this.listingType,
    required this.propertyType,
    required this.propertyCategory,
    required this.residentialDetails,
    required this.pricing,
    required this.location,
    required this.contact,
    required this.images,
    required this.description,
  });

  final String? listingType;
  final String? propertyType;
  final String? propertyCategory;
  final ResidentialDetails? residentialDetails;
  final Pricing? pricing;
  final Location? location;
  final Contact? contact;

  final List<String> images;
  final String? description;

  Map<String, dynamic> toJson() => {
    "listingType": listingType,
    "propertyType": propertyType,
    "propertyCategory": propertyCategory,
    "residentialDetails": residentialDetails?.toJson(),
    "pricing": pricing?.toJson(),
    "location": location?.toJson(),
    "contact": contact?.toJson(),
    "images": images.map((x) => x).toList(),
    "description": description,
  };
}

class Pricing {
  Pricing({
    required this.rent,
    required this.securityDeposit,
    required this.noticePeriod,
    required this.lockInPeriod,
  });

  final Rent? rent;
  final SecurityDeposit? securityDeposit;
  final int? noticePeriod;
  final LockInPeriod? lockInPeriod;

  Map<String, dynamic> toJson() => {
    "rent": rent?.toJson(),
    "securityDeposit": securityDeposit?.toJson(),
    "noticePeriod": noticePeriod,
    "lockInPeriod": lockInPeriod?.toJson(),
  };
}

class SecurityDeposit {
  SecurityDeposit({required this.label, required this.amount});

  final String? label;
  final int? amount;

  Map<String, dynamic> toJson() => {"depositType": label, "amount": amount};
}

class Rent {
  Rent({
    this.pricingRoomtype,
    this.rentAmount,
    this.leaseAmount,
    this.numberOfYearLease,
    this.isElectricity,
    this.isNegotiable,
    this.istaxAndGov,
    this.yearlyRentIncreaseByPercent,
  });

  final String? pricingRoomtype;
  final int? rentAmount;
  final int? leaseAmount;
  final String? numberOfYearLease;
  final bool? isElectricity;
  final bool? isNegotiable;
  final bool? istaxAndGov;
  final int? yearlyRentIncreaseByPercent;

  Map<String, dynamic> toJson() => {
    "pricingRoomtype": pricingRoomtype, // exactly same as backend
    "rentAmount": rentAmount,
    "leaseAmount": leaseAmount,
    "numberOfYearLease": numberOfYearLease,
    "isElectricity": isElectricity,
    "isNegotiable": isNegotiable,
    "istaxAndGov": istaxAndGov,
    "YearlyRentIncreaseByPercent": yearlyRentIncreaseByPercent,
  };
}

class ResidentialDetails {
  ResidentialDetails({
    required this.ageOfProperty,
    required this.bhkType,
    required this.bathrooms,
    required this.balconies,
    required this.additionalRooms,
    required this.furnishing,
    required this.facing,
    required this.flooring,
    required this.area,
    required this.parking,
    required this.totalFloors,
    required this.yourFloor,
    required this.preferredTenants,
    required this.availableFrom,
    required this.isBroker,
  });

  final String? ageOfProperty;
  final String? bhkType;
  final String? bathrooms;
  final String? balconies;
  final List<String> additionalRooms;
  final Furnishing? furnishing;
  final String? facing;
  final String? flooring;
  final Area? area;
  final Parking? parking;
  final int? totalFloors;
  final int? yourFloor;
  final List<String> preferredTenants;
  final DateTime? availableFrom;
  final bool? isBroker;

  Map<String, dynamic> toJson() => {
    "ageOfProperty": ageOfProperty,
    "bhkType": bhkType,
    "bathrooms": bathrooms,
    "balconies": balconies,
    "additionalRooms": additionalRooms.map((x) => x).toList(),
    "furnishing": furnishing?.toJson(),
    "facing": facing,
    "flooring": flooring,
    "area": area?.toJson(),
    "parking": parking?.toJson(),
    "totalFloors": totalFloors,
    "yourFloor": yourFloor,
    "preferredTenants": preferredTenants.map((x) => x).toList(),
    "availableFrom": availableFrom?.toIso8601String(),
    "isBroker": isBroker,
  };
}

class Area {
  Area({required this.builtUp, required this.carpet});

  final BuiltUp? builtUp;
  final BuiltUp? carpet;

  Map<String, dynamic> toJson() => {
    "builtUp": builtUp?.toJson(),
    "carpet": carpet?.toJson(),
  };
}

class BuiltUp {
  BuiltUp({required this.value, required this.unit});

  final int? value;
  final String? unit;

  Map<String, dynamic> toJson() => {"value": value, "unit": unit};
}

class Parking {
  Parking({required this.parkingDetails});

  final List<ParkingDetail> parkingDetails;

  Map<String, dynamic> toJson() => {
    "parkingDetails": parkingDetails.map((x) => x.toJson()).toList(),
  };
}

class ParkingDetail {
  ParkingDetail({required this.label, required this.value});

  final String? label;
  final int? value;

  Map<String, dynamic> toJson() => {"label": label, "value": value};
}
