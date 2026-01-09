import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/home_screen/location_screen.dart';
import 'package:token_app/viewModel/afterLogin/filter_pages_provider/filter_provider.dart';

class RentFliterPage extends StatelessWidget {
  const RentFliterPage({super.key});

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
                                      Text('Search city/Locality/Landmarks...'),
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
                        Row(
                          children: [
                            _selectButton("Residential", provider),
                            const SizedBox(width: 10),
                            _selectButton("Commercial", provider),
                          ],
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Property Type",
                          style: textStyle15(FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        provider.rentType == 'Residential'
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: provider.propertyType.map((e) {
                                      return filterChip(
                                        text: e,
                                        isSelected: provider
                                            .selectedPropertyType
                                            .contains(e),
                                        onTap: () {
                                          provider.toggleSelection(
                                            provider.selectedPropertyType,
                                            e,
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                                  SizedBox(height: 15),

                                  // tenant
                                  Text(
                                    "Preferred Tenanut",
                                    style: textStyle15(FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: provider.prefeTenant.map((e) {
                                      return filterChip(
                                        text: e,
                                        isSelected: provider.selectedTenant
                                            .contains(e),
                                        onTap: () {
                                          provider.toggleSelection(
                                            provider.selectedTenant,
                                            e,
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),

                                  // bhk type
                                  SizedBox(height: 15),
                                  Text(
                                    "BHK Type",
                                    style: textStyle15(FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: provider.bhkType.map((e) {
                                      return filterChip(
                                        text: e,
                                        isSelected: provider.selectedBhk
                                            .contains(e),
                                        onTap: () {
                                          provider.toggleSelection(
                                            provider.selectedBhk,
                                            e,
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ],
                              )
                            : Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: provider.commercialPropertyType.map((
                                  e,
                                ) {
                                  return filterChip(
                                    text: e,
                                    isSelected: provider
                                        .selectedCommPropertyType
                                        .contains(e),
                                    onTap: () {
                                      provider.toggleSelection(
                                        provider.selectedCommPropertyType,
                                        e,
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                        SizedBox(height: 15),
                        Text("Budget", style: textStyle15(FontWeight.bold)),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: budgetBox(provider.selectedMinBudget, () {
                                showChecklistBottomSheet(
                                  context: context,
                                  title: "Select Min Budget",
                                  items: provider.budgetList,
                                  selectedValue: provider.selectedMinBudget,
                                  onSelected: provider.setMinBudget,
                                );
                              }),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: budgetBox(provider.selectedMaxBudget, () {
                                showChecklistBottomSheet(
                                  context: context,
                                  title: "Select Max Budget",
                                  items: provider.budgetList,
                                  selectedValue: provider.selectedMaxBudget,
                                  onSelected: provider.setMaxBudget,
                                );
                              }),
                            ),
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
                            Expanded(
                              child: budgetBox(provider.selectedMinArea, () {
                                showChecklistBottomSheet(
                                  context: context,
                                  title: "Select Min Area",
                                  items: provider.areaList,
                                  selectedValue: provider.selectedMinArea,
                                  onSelected: provider.setMinArea,
                                );
                              }),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: budgetBox(provider.selectedMaxArea, () {
                                showChecklistBottomSheet(
                                  context: context,
                                  title: "Select Max Area",
                                  items: provider.areaList,
                                  selectedValue: provider.selectedMaxArea,
                                  onSelected: provider.setMaxArea,
                                );
                              }),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),
                        provider.rentType == 'Residential'
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Furnish Type",
                                    style: textStyle15(FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: provider.furnishType.map((e) {
                                      return filterChip(
                                        text: e,
                                        isSelected: provider.selectedFurnish
                                            .contains(e),
                                        onTap: () {
                                          provider.toggleSelection(
                                            provider.selectedFurnish,
                                            e,
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),

                        SizedBox(height: 100),
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

  Widget _selectButton(String text, FilterProvider provider) {
    return Expanded(
      child: Selector<FilterProvider, String>(
        selector: (_, p) => p.rentType,
        builder: (context, value, child) {
          final isSelector = value == text;
          return GestureDetector(
            onTap: () {
              provider.toggleRent(text);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isSelector
                      ? AppColors.mainColors
                      : Colors.grey.shade300,
                ),
                color: Colors.transparent,
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: isSelector ? AppColors.mainColors : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
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

Widget filterChip({
  required String text,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isSelected ? AppColors.mainColors : Colors.grey.shade300,
        ),
        color: isSelected
            ? AppColors.mainColors.withOpacity(0.1)
            : Colors.transparent,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? AppColors.mainColors : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

class CheckListTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CheckListTile({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: AppColors.mainColors)
          : Icon(Icons.radio_button_unchecked),
    );
  }
}

void showChecklistBottomSheet({
  required BuildContext context,
  required String title,
  required List<String> items,
  required String? selectedValue,
  required Function(String) onSelected,
}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(title, style: textStyle15(FontWeight.bold)),
          ),
          Divider(),
          ...items.map((e) {
            return CheckListTile(
              title: e,
              isSelected: selectedValue == e,
              onTap: () {
                onSelected(e);
                Navigator.pop(context);
              },
            );
          }),
          SizedBox(height: 10),
        ],
      );
    },
  );
}
