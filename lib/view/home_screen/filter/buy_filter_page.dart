import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/home_screen/location_screen.dart';
import 'package:token_app/viewModel/afterLogin/filter_pages_provider/filter_provider.dart';

class BuyFilterPage extends StatelessWidget {
  final String? city;
  const BuyFilterPage({super.key, this.city});

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(
      builder: (context, provider, child) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Search By City, Locality *",
                          style: textStyle15(FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LocationScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: AppColors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.search, color: AppColors.grey),
                                      SizedBox(width: 5),
                                      Text(
                                        provider.city.isEmpty
                                            ? 'Search city/Locality/Landmarks...'
                                            : provider.city,
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.location_on_outlined),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text("To Rent", style: textStyle15(FontWeight.bold)),
                        SizedBox(height: 10),
                        _toggleButtons(),
                        SizedBox(height: 15),
                        Text(
                          "Property Type",
                          style: textStyle15(FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: propertyType.map((e) {
                            return _chipWrap(e);
                          }).toList(),
                        ),
                        SizedBox(height: 15),

                        // tenant
                        Text(
                          "Property Condition",
                          style: textStyle15(FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: propertyCondition.map((e) {
                            return _chipWrap(e);
                          }).toList(),
                        ),

                        // bhk type
                        SizedBox(height: 15),
                        Text("BHK Type", style: textStyle15(FontWeight.bold)),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: bhkType.map((e) {
                            return _chipWrap(e);
                          }).toList(),
                        ),

                        SizedBox(height: 15),
                        Text("Budget", style: textStyle15(FontWeight.bold)),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(child: budgetBox("1K", () {})),
                            SizedBox(width: 10),
                            Expanded(child: budgetBox("1K", () {})),
                          ],
                        ),

                        SizedBox(height: 15),
                        Text(
                          "Built up area",
                          style: textStyle15(FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(child: budgetBox("100 sq ft", () {})),
                            SizedBox(width: 10),
                            Expanded(child: budgetBox("4000+ sq ft", () {})),
                          ],
                        ),

                        SizedBox(height: 15),
                        Text(
                          "Furnish Type",
                          style: textStyle15(FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: furnishType.map((e) {
                            return _chipWrap(e);
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.white),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: "Clear All",
                        onTap: () {},
                        backgroundColor: AppColors.mainColors.withAlpha(20),

                        textColor: AppColors.black,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: AppButton(text: "Submit", onTap: () {}),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _toggleButtons() {
    return Row(
      children: [
        _selectButton("Residential", 0),
        const SizedBox(width: 10),
        _selectButton("Commercial", 1),
      ],
    );
  }

  Widget _selectButton(String text, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.transparent,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _chipWrap(String type) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade300),
          color: AppColors.white,
        ),
        child: Text(
          type,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

Widget budgetBox(String value, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Row(
          children: [
            Text(value),
            Spacer(),
            Icon(Icons.keyboard_arrow_down_outlined),
          ],
        ),
      ),
    ),
  );
}

List<String> propertyType = [
  "Apartment",
  "Builder Floor",
  "Independent House",
  "Villa",
];

List<String> propertyCondition = ["Ready to move", "Under Construction"];
List<String> bhkType = ["1BHK", "2BHK", "3BHK", "4BHK", "5BHK", "5+BHK"];

List<String> furnishType = [
  "Fully Furnished",
  " Semi Furnished",
  "Unfurnished",
];
