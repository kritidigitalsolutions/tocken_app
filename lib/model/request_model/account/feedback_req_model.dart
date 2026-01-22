class FeedbackReqModel {
  final String type;
  final String description;
  final String name;
  final String phone;
  final String? email;

  FeedbackReqModel({
    required this.type,
    required this.description,
    required this.name,
    required this.phone,
    this.email,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "feedbackType": type,
      "description": description,
      "name": name,
      "phone": phone,
    };

    if (email != null && email!.isNotEmpty) {
      data["email"] = email;
    }

    return data;
  }
}
