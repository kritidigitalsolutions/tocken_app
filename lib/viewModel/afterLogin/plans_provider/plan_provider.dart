import 'package:flutter/material.dart';
import 'package:token_app/data/api_response.dart';
import 'package:token_app/model/response_model/plan/plan_res_model.dart';
import 'package:token_app/repository/plan_repo.dart';

class PlanDetailsProvider extends ChangeNotifier {
  final PlanRepo _repo = PlanRepo();

  List<String> featureOption = [
    'Secure payment gateway',
    "Cancel anytime, no questions",
    "GST invoice available",
  ];

  final List<UserRole> roles = [
    UserRole(title: "Agent", icon: "assets/plan_icon/sale.svg"),
    UserRole(title: "Seller", icon: "assets/plan_icon/buyer.svg"),
    UserRole(title: "Landlord", icon: "assets/plan_icon/search.svg"),
    UserRole(title: "PG Owner", icon: "assets/plan_icon/buyer.svg"),
    UserRole(title: "Buyer", icon: "assets/plan_icon/sale.svg"),
    UserRole(title: "Tenant", icon: "assets/plan_icon/search.svg"),
    UserRole(title: "Co-living", icon: "assets/plan_icon/buyer.svg"),
    UserRole(title: "PG Seeker", icon: "assets/plan_icon/sale.svg"),
  ];

  String? selectedRole;

  void selectRole(String role) {
    selectedRole = role;
    notifyListeners();
  }

  bool get isSelected => selectedRole != null;

  // Plan fetch

  ApiResponse<PlanResModel> plans = ApiResponse.loading();

  Future<void> fetchPlans(String type) async {
    plans = ApiResponse.loading();
    notifyListeners();
    fetchFaq();
    try {
      final data = await _repo.fetchPlans(type);
      plans = ApiResponse.completed(data);
      setInitialPlan();
    } catch (e) {
      print(e.toString());
      plans = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  // feature add

  Plan? _selectedPlan;
  Plan? get selectedPlan => _selectedPlan;

  /// Call after API success
  void setInitialPlan() {
    if (plans.data != null && plans.data!.plans.isNotEmpty) {
      _selectedPlan ??= plans.data!.plans.first;
      notifyListeners();
    }
  }

  void selectPlan(Plan plan) {
    _selectedPlan = plan;
    notifyListeners();
  }

  // FAQ fetch

  ApiResponse<FAQResMOdel> faqs = ApiResponse.loading();

  Future<void> fetchFaq() async {
    faqs = ApiResponse.loading();
    notifyListeners();
    try {
      final data = await _repo.fetchFaq();
      faqs = ApiResponse.completed(data);
    } catch (e) {
      print(e.toString());
      faqs = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}

class UserRole {
  final String title;
  final String icon;

  UserRole({required this.title, required this.icon});
}
