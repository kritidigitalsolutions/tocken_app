import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/view/home_screen/filter/buy_filter_page.dart';
import 'package:token_app/view/home_screen/filter/coliving_filter_page.dart';
import 'package:token_app/view/home_screen/filter/pg_filter.dart';
import 'package:token_app/view/home_screen/filter/plot_land_page.dart';
import 'package:token_app/view/home_screen/filter/rent_fliter_page.dart';
import 'package:token_app/viewModel/afterLogin/filter_pages_provider/filter_provider.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int selectedRentType = 0;
  String? selectedProperty;
  String? selectedTenant;

  final tenants = ["Family", "Male", "Female", "Others"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    Future.microtask(() {
      context.read<FilterProvider>().getCity();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pro = context.read<FilterProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Filter",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: AppColors.mainColors,
          labelColor: AppColors.mainColors,
          unselectedLabelColor: Colors.black,
          tabs: const [
            Tab(text: "Rent/Lease"),
            Tab(text: "Co-living"),
            Tab(text: "PG"),
            Tab(text: "Buy"),
            Tab(text: "Plot/Land"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          RentFliterPage(city: pro.city),
          ColivingFilterPage(city: pro.city),
          PgFilter(city: pro.city),
          BuyFilterPage(city: pro.city),
          PlotLandPage(city: pro.city),
        ],
      ),
    );
  }
}
