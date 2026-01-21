class PlanResModel {
  PlanResModel({required this.success, required this.plans});

  final bool? success;
  final List<Plan> plans;

  factory PlanResModel.fromJson(Map<String, dynamic> json) {
    return PlanResModel(
      success: json["success"],
      plans: json["plans"] == null
          ? []
          : List<Plan>.from(json["plans"]!.map((x) => Plan.fromJson(x))),
    );
  }
}

class Plan {
  Plan({
    required this.id,
    required this.tag,
    required this.price,
    required this.originalPrice,
    required this.validityInDays,
    required this.features,
    required this.gstIncluded,
    required this.offerEndsInDays,
    required this.planName,
    required this.validityDays,
    required this.userType,
  });

  final String? id;
  final String? tag;
  final int? price;
  final int? originalPrice;
  final int? validityInDays;
  final List<String> features;
  final bool? gstIncluded;
  final int? offerEndsInDays;
  final String? planName;
  final int? validityDays;
  final String? userType;

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json["_id"],
      tag: json["tag"],
      price: json["price"],
      originalPrice: json["originalPrice"],
      validityInDays: json["validityInDays"],
      features: json["features"] == null
          ? []
          : List<String>.from(json["features"]!.map((x) => x)),
      gstIncluded: json["gstIncluded"],
      offerEndsInDays: json["offerEndsInDays"],
      planName: json["planName"],
      validityDays: json["validityDays"],
      userType: json["userType"],
    );
  }
}

// FAQ model

class FAQResMOdel {
  final bool? success;
  final List<FAQModel>? faqs;

  FAQResMOdel({required this.faqs, required this.success});

  factory FAQResMOdel.fromJson(Map<String, dynamic> j) {
    return FAQResMOdel(
      faqs: j["faqs"] == null
          ? []
          : (j["faqs"] as List).map((json) => FAQModel.fromJson(json)).toList(),
      success: j["success"],
    );
  }
}

class FAQModel {
  final String? ques;
  final String? ans;

  FAQModel({required this.ques, required this.ans});

  factory FAQModel.fromJson(Map<String, dynamic> j) {
    return FAQModel(ques: j["question"], ans: j["answer"]);
  }
}
