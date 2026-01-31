import 'package:token_app/model/request_model/post_property/common_property_req_model.dart';

class CoLivingReqModel {
  CoLivingReqModel({
    required this.listingType,
    required this.propertyCategory,
    required this.coLivingDetails,
    required this.pricing,
    required this.location,
    required this.images,
    required this.description,
  });

  final String? listingType;
  final String? propertyCategory;
  final CoLivingDetails? coLivingDetails;
  final CoLivingPricing? pricing;
  final Location? location;
  List<String>? images;
  final String? description;

  Map<String, dynamic> toJson() => {
    "listingType": listingType,
    "propertyCategory": propertyCategory,
    "coLivingDetails": coLivingDetails?.toJson(),
    "pricing": pricing?.toJson(),
    "location": location?.toJson(),
    if (images != null && images!.isNotEmpty)
      "images": images!.map((x) => x).toList(),
    "description": description,
  };
}

class CoLivingDetails {
  CoLivingDetails({
    required this.profileImage,
    required this.name,
    required this.mobileNumber,
    required this.isPhonePrivate,
    required this.dateOfBirth,
    required this.gender,
    required this.occupation,
    required this.occupationName,
    required this.languages,
    required this.hobbies,
    required this.availableFrom,
    required this.lookingToShiftBy,
    required this.bhk,
    required this.furnishing,
    required this.roomDetails,
    required this.totalFloors,
    required this.yourFloor,
    required this.societyAmenities,
    required this.budgetRange,
    required this.partnerGender,
    required this.ageLimit,
    required this.partnerOccupation,
    required this.preferences,
    required this.instagramLink,
    required this.facebookLink,
    required this.linkedInLink,
  });

  final String? profileImage;
  final String? name;
  final String? mobileNumber;
  final bool? isPhonePrivate;
  final String? dateOfBirth;
  final String? gender;
  final String? occupation;
  final String? occupationName;
  final String? languages;
  final String? hobbies;
  final String? availableFrom;
  final String? lookingToShiftBy;
  final String? bhk;
  final Furnishing? furnishing;
  final List<String> roomDetails;
  final int? totalFloors;
  final int? yourFloor;
  final List<String> societyAmenities;
  final AgeLimit? budgetRange;
  final String? partnerGender;
  final AgeLimit? ageLimit;
  final List<String> partnerOccupation;
  final List<String> preferences;
  final String? instagramLink;
  final String? facebookLink;
  final String? linkedInLink;

  Map<String, dynamic> toJson() => {
    "profileImage": profileImage,
    "name": name,
    "mobileNumber": mobileNumber,
    "isPhonePrivate": isPhonePrivate,
    "dateOfBirth": dateOfBirth,
    "gender": gender,
    "occupation": occupation,
    "occupationName": occupationName,
    "languages": languages,
    "hobbies": hobbies,
    "availableFrom": availableFrom,
    "lookingToShiftBy": lookingToShiftBy,
    "bhk": bhk,
    "furnishing": furnishing?.toJson(),
    "roomDetails": roomDetails.map((x) => x).toList(),
    "totalFloors": totalFloors,
    "yourFloor": yourFloor,
    "amenities": societyAmenities.map((x) => x).toList(),
    "budgetRange": budgetRange?.toJson(),
    "partnerGender": partnerGender,
    "ageLimit": ageLimit?.toJson(),
    "partnerOccupation": partnerOccupation.map((x) => x).toList(),
    "preferences": preferences.map((x) => x).toList(),
    "instagramLink": instagramLink,
    "facebookLink": facebookLink,
    "linkedInLink": linkedInLink,
  };
}

class AgeLimit {
  AgeLimit({required this.min, required this.max});

  final int? min;
  final int? max;

  Map<String, dynamic> toJson() => {"min": min, "max": max};
}

class CoLivingPricing {
  CoLivingPricing({required this.rent, required this.additionalCharges});

  final COLivingRent? rent;
  final AdditionalCharges? additionalCharges;

  Map<String, dynamic> toJson() => {
    "rent": rent?.toJson(),
    "additionalCharges": additionalCharges?.toJson(),
  };
}

class AdditionalCharges {
  AdditionalCharges({
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

class COLivingRent {
  COLivingRent({
    required this.rentAmount,
    required this.isElectricityIncluded,
    required this.isNegotiable,
  });

  final int? rentAmount;
  final bool? isElectricityIncluded;
  final bool? isNegotiable;

  Map<String, dynamic> toJson() => {
    "rentAmount": rentAmount,
    "isElectricityIncluded": isElectricityIncluded,
    "isNegotiable": isNegotiable,
  };
}
