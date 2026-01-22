class OnBoardingResModel {
  final bool? success;
  final List<Wallpapers>? wall;

  OnBoardingResModel({required this.success, required this.wall});

  factory OnBoardingResModel.fromJson(Map<String, dynamic> j) {
    return OnBoardingResModel(
      success: j["success"],
      wall: j['wallpapers'] == null
          ? []
          : (j["wallpapers"] as List)
                .map((json) => Wallpapers.fromJson(json))
                .toList(),
    );
  }
}

class Wallpapers {
  final String? title;
  final String? des;
  final String? image;

  Wallpapers({required this.des, required this.image, required this.title});

  factory Wallpapers.fromJson(Map<String, dynamic> j) {
    return Wallpapers(
      des: j["description"],
      image: j["image"],
      title: j["title"],
    );
  }
}
