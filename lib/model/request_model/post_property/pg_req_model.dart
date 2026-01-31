import 'package:token_app/model/request_model/post_property/common_property_req_model.dart';

class PgReqModel {
  PgReqModel({
    required this.listingType,
    required this.pgDetails,
    required this.pricing,
    required this.location,
    required this.contact,
    this.images,
    required this.description,
  });

  final String? listingType;
  final PgDetails? pgDetails;
  final PGPricing? pricing;
  final Location? location;
  final PGContact? contact;
  final List<String>? images;
  final String? description;

  Map<String, dynamic> toJson() => {
    "listingType": listingType,
    "pgDetails": pgDetails?.toJson(),
    "pricing": pricing?.toJson(),
    "location": location?.toJson(),
    "contact": contact?.toJson(),
    if (images != null && images!.isNotEmpty)
      "images": images!.map((x) => x).toList(),
    "description": description,
  };
}

class PGContact {
  PGContact({
    required this.phone,
    required this.phonePrivate,
    required this.amenities,
    required this.pgRules,
    required this.lastEntryTime,
    required this.commonArea,
  });

  final String? phone;
  final bool? phonePrivate;
  final List<String> amenities;
  final List<String> pgRules;
  final String? lastEntryTime;
  final List<String> commonArea;

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "phonePrivate": phonePrivate,
    "amenities": amenities.map((x) => x).toList(),
    "pgRules": pgRules.map((x) => x).toList(),
    "LastEntryTime": lastEntryTime,
    "commonArea": commonArea.map((x) => x).toList(),
  };
}

class PgDetails {
  PgDetails({
    required this.pgName,
    required this.pgFor,
    required this.bestSuitedFor,
    required this.totalFloors,
    required this.roomTypes,
    required this.furnishing,
    required this.parking,
    required this.managedBy,
    required this.managerStaysAtPg,
    required this.availableFrom,
    required this.includedServices,
  });

  final String? pgName;
  final String? pgFor;
  final List<String> bestSuitedFor;
  final int? totalFloors;
  final List<RoomType> roomTypes;
  final Furnishing? furnishing;
  final PGParking? parking;
  final String? managedBy;
  final bool? managerStaysAtPg;
  final String? availableFrom;
  final List<String> includedServices;

  Map<String, dynamic> toJson() => {
    "pgName": pgName,
    "pgFor": pgFor,
    "bestSuitedFor": bestSuitedFor.map((x) => x).toList(),
    "totalFloors": totalFloors,
    "roomTypes": roomTypes.map((x) => x.toJson()).toList(),
    "furnishing": furnishing?.toJson(),
    "parking": parking?.toJson(),
    "managedBy": managedBy,
    "managerStaysAtPG": managerStaysAtPg,
    "availableFrom": availableFrom,
    "includedServices": includedServices.map((x) => x).toList(),
  };
}

class PGParking {
  PGParking({required this.covered, required this.open});

  final int? covered;
  final int? open;

  Map<String, dynamic> toJson() => {"covered": covered, "open": open};
}

class RoomType {
  RoomType({
    required this.sharingType,
    required this.roomsAvailable,
    required this.rentAmount,
    required this.securityDepositType,
    required this.amount,
    required this.attachedBathroom,
    required this.attachedBalcony,
  });

  final String? sharingType;
  final int? roomsAvailable;
  final int? rentAmount;
  final String? securityDepositType;
  final int? amount;
  final bool? attachedBathroom;
  final bool? attachedBalcony;

  Map<String, dynamic> toJson() => {
    "sharingType": sharingType,
    "roomsAvailable": roomsAvailable,
    "rentAmount": rentAmount,
    "securityDepositType": securityDepositType,
    "amountOrMonth": amount,
    "attachedBathroom": attachedBathroom,
    "attachedBalcony": attachedBalcony,
  };
}

class PGPricing {
  PGPricing({
    required this.addMore,
    required this.rent,
    required this.mealsAvailable,
    required this.mealsType,
    required this.mealsAvailableOnWeekdays,
    required this.mealsAmount,
    required this.noticePeriod,
    required this.lockInPeriod,
  });

  final AddMore addMore;
  final PGRent? rent;
  final String? mealsAvailable;
  final String? mealsType;
  final List<String> mealsAvailableOnWeekdays;
  final int? mealsAmount;
  final int? noticePeriod;
  final LockInPeriod? lockInPeriod;

  Map<String, dynamic> toJson() => {
    "addMore": addMore.toJson(),
    "rent": rent?.toJson(),
    "mealsAvailable": mealsAvailable,
    "mealsType": mealsType,
    "mealsAvailableOnWeekdays": mealsAvailableOnWeekdays.map((x) => x).toList(),
    "mealsAmount": mealsAmount,
    "noticePeriod": noticePeriod,
    "lockInPeriod": lockInPeriod?.toJson(),
  };
}

class AddMore {
  AddMore({
    required this.maintenanceCharge,
    required this.bookingAmount,
    required this.otherCharge,
  });

  final int? maintenanceCharge;
  final int? bookingAmount;
  final int? otherCharge;

  Map<String, dynamic> toJson() => {
    "maintenanceCharge": maintenanceCharge,
    "bookingAmount": bookingAmount,
    "otherCharge": otherCharge,
  };
}

class PGRent {
  PGRent({required this.isElectricity, required this.isNegotiable});

  final bool? isElectricity;
  final bool? isNegotiable;

  Map<String, dynamic> toJson() => {
    "isElectricity": isElectricity,
    "isNegotiable": isNegotiable,
  };
}
