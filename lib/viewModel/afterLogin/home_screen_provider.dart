import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:token_app/view/account_page/profile_page.dart';
import 'package:token_app/view/home_screen/home_screen.dart';
import 'package:token_app/view/leadsPage/leadsPage.dart';
import 'package:token_app/view/plans_pages/plans_pages.dart';

class HomeScreenProvicer extends ChangeNotifier {
  HomeScreenProvicer() {
    getCity();
  }
  // city ==================
  //
  // city===================

  String city = "city";
  Future<void> getCity() async {
    final pref = await SharedPreferences.getInstance();
    city = pref.getString("city") ?? '';
  }

  String _categoryTitle = "";
  String get categoryTitle => _categoryTitle;

  void toggleCategory(String type) {
    _categoryTitle = type;
    notifyListeners();
  }

  String _bhkTitle = "";
  String get bhkTitle => _bhkTitle;

  void toggleBHK(String type) {
    _bhkTitle = type;
    notifyListeners();
  }

  // Change page

  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  void toggelPage(int index) {
    _pageIndex = index;
    notifyListeners();
  }

  List<Widget> screenPage = [
    HomeScreen(),
    LeadsView(),
    PlansPage(),
    ProfilePage(),
  ];

  void clearAll() {
    _categoryTitle = '';
    _bhkTitle = '';
    notifyListeners();
  }
}
