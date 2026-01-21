class PolicyResModel {
  final bool? success;
  final LegalData? legal;

  PolicyResModel({required this.success, required this.legal});

  factory PolicyResModel.fromJson(Map<String, dynamic> j) {
    return PolicyResModel(
      success: j['success'],
      legal: j["legal"] == null ? null : LegalData.fromJson(j['legal']),
    );
  }
}

class LegalData {
  final String? id;
  final String type;
  final String? title;
  final String? content;

  LegalData({
    required this.id,
    required this.content,
    required this.title,
    required this.type,
  });

  factory LegalData.fromJson(Map<String, dynamic> j) {
    return LegalData(
      id: j["_id"],
      content: j["content"],
      title: j["title"],
      type: j["type"],
    );
  }
}

// About -us

class AboutUsResModel {
  final bool? success;
  final AboutUsData? aboutUs;

  AboutUsResModel({required this.success, required this.aboutUs});

  factory AboutUsResModel.fromJson(Map<String, dynamic> j) {
    return AboutUsResModel(
      success: j['success'],
      aboutUs: j["aboutUs"] == null ? null : AboutUsData.fromJson(j['aboutUs']),
    );
  }
}

class AboutUsData {
  final String mission;
  final String? title;
  final String? content;
  final String? vision;
  AboutUsData({
    required this.content,
    required this.title,
    required this.mission,
    required this.vision,
  });

  factory AboutUsData.fromJson(Map<String, dynamic> j) {
    return AboutUsData(
      content: j["content"],
      title: j["title"],
      mission: j["mission"],
      vision: j["vision"],
    );
  }
}
