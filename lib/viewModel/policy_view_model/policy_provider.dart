import 'package:flutter/material.dart';
import 'package:token_app/data/api_response.dart';
import 'package:token_app/data/app_exception.dart';
import 'package:token_app/model/response_model/policy/policy_res_model.dart';
import 'package:token_app/repository/policy_repo.dart';

class PolicyProvider extends ChangeNotifier {
  final PolicyRepo repo = PolicyRepo();

  // ---------------- Policy --------------

  ApiResponse<PolicyResModel> policy = ApiResponse.loading();

  Future<void> fetchPolicy(String type) async {
    policy = ApiResponse.loading();
    notifyListeners();

    try {
      final data = await repo.fetchPolicy(type);
      policy = ApiResponse.completed(data);
      print("policy -- - -- - --- - -- $policy");
    } on AppException catch (e) {
      print(e.toString());
      policy = ApiResponse.error(e.message);
    } catch (e) {
      print(e.toString());
      policy = ApiResponse.error('Something went wrong');
    }

    notifyListeners();
  }

  // ------------------- About - us -----------------

  ApiResponse<AboutUsResModel> aboutUs = ApiResponse.loading();

  Future<void> fetchAboutUs() async {
    aboutUs = ApiResponse.loading();
    notifyListeners();

    try {
      final data = await repo.fetchAboutUs();
      aboutUs = ApiResponse.completed(data);
      print("about-us -- - -- - --- - -- $aboutUs");
    } on AppException catch (e) {
      print(e.toString());
      aboutUs = ApiResponse.error(e.message);
    } catch (e) {
      print(e.toString());
      aboutUs = ApiResponse.error('Something went wrong');
    }

    notifyListeners();
  }
}
