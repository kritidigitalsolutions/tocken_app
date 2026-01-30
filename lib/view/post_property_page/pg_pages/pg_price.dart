import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/utils/textfield.dart';
import 'package:token_app/view/post_property_page/address_details_page.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/pg_provider.dart';

class PgPrice extends StatefulWidget {
  const PgPrice({super.key});

  @override
  State<PgPrice> createState() => _PgPriceState();
}

class _PgPriceState extends State<PgPrice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      /// APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        leading: const BackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pricing",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              "PG",
              style: TextStyle(color: AppColors.grey.shade600, fontSize: 13),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextAppButton(text: "Help", onTap: () {}),
          ),
        ],
      ),

      /// BODY
      body: Consumer<PgDetailsProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Rent Amount
                ///
                Column(
                  children: provider.roomSharing.map((room) {
                    final securityType = provider.getSecurityType(room);
                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: AppColors.grey),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitle("$room Room Rent Amount*"),
                          AppTextField(
                            controller: provider.roomAmountCtr[room]!,
                            hintText: "Enter rent amount per room",
                            prefixIcon: const Icon(Icons.currency_rupee_sharp),
                          ),

                          const SizedBox(height: 15),
                          _sectionTitle("Security Deposit"),
                          Wrap(
                            spacing: 10,
                            children: [
                              boolChoiceChip(
                                "Fixed",
                                provider.getSecurityType(room) ==
                                    SecurityDepositType.fixed,
                                () => provider.setSecurityType(
                                  room,
                                  SecurityDepositType.fixed,
                                ),
                              ),
                              boolChoiceChip(
                                "Multiple of Rent",
                                provider.getSecurityType(room) ==
                                    SecurityDepositType.multiple,
                                () => provider.setSecurityType(
                                  room,
                                  SecurityDepositType.multiple,
                                ),
                              ),
                              boolChoiceChip(
                                "None",
                                provider.getSecurityType(room) ==
                                    SecurityDepositType.none,
                                () => provider.setSecurityType(
                                  room,
                                  SecurityDepositType.none,
                                ),
                              ),
                            ],
                          ),

                          if (securityType == SecurityDepositType.fixed) ...[
                            const SizedBox(height: 10),
                            AppTextField(
                              controller:
                                  provider.fixedDepositCtr[room] ??
                                  TextEditingController(),
                              hintText: "Enter fixed deposit amount",
                              prefixIcon: const Icon(
                                Icons.currency_rupee_sharp,
                              ),
                            ),
                          ],

                          if (securityType == SecurityDepositType.multiple) ...[
                            const SizedBox(height: 10),
                            AppTextField(
                              controller:
                                  provider.fixedDepositCtr[room] ??
                                  TextEditingController(),
                              hintText: "Enter no. of months (max 36)",
                              prefixIcon: const Icon(
                                Icons.currency_rupee_sharp,
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),

                /// Add More Pricing
                Text(
                  "+ Add More Pricing Details",
                  style: TextStyle(
                    color: AppColors.mainColors,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 20),

                /// Checkboxes
                _checkTile(
                  "Is the price negotiable ?",
                  provider.negotiable,
                  (v) => provider.toggleNegotiable(v),
                ),
                _checkTile(
                  "Is electricity and water charge included?",
                  provider.utilitiesIncluded,
                  (v) => provider.toggleutilitiesIncludede(v),
                ),

                const SizedBox(height: 24),

                /// Included Services
                _sectionTitle("Select Included Services"),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(provider.serviceList.length, (index) {
                    final service = provider.serviceList[index];
                    return boolChoiceChip(
                      service,
                      provider.isSelectedService(service),
                      () {
                        provider.toggleService(service);
                      },
                    );
                  }),
                ),

                const SizedBox(height: 24),

                /// Meals Available
                _sectionTitle("Meals Available *"),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _choiceChip("Yes", provider.mealsAvailable, (v) {
                      provider.setMealsAvailable(v);
                    }),
                    _choiceChip("No", provider.mealsAvailable, (v) {
                      provider.setMealsAvailable(v);
                    }),
                    _choiceChip("Extra fees apply", provider.mealsAvailable, (
                      v,
                    ) {
                      provider.setMealsAvailable(v);
                    }),
                  ],
                ),

                const SizedBox(height: 24),

                /// Meal Type
                if (provider.showMealDetails) ...[
                  _sectionTitle("Meals Type"),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _choiceChip("Only Veg", provider.mealType, (v) {
                        provider.setMealType(v);
                      }),
                      _choiceChip("Veg & Non Veg", provider.mealType, (v) {
                        provider.setMealType(v);
                      }),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// Meal Time
                  _sectionTitle("Meals Availability on Weekdays? *"),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: provider.mealTimeList.map((type) {
                      return boolChoiceChip(
                        type,
                        provider.isSelectedMealTime(type),
                        () {
                          provider.setMealTime(type);
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),
                ],

                /// Meal Amount
                if (provider.mealsAvailable == "Extra fees apply") ...[
                  _sectionTitle("Meal Amount *"),
                  AppTextField(
                    controller: provider.mealAmountCtr,
                    hintText: "Enter meal amount",
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.currency_rupee_sharp),
                  ),

                  const SizedBox(height: 24),
                ],

                /// Notice Period
                _sectionTitle("Notice Period (in months)"),
                Wrap(
                  spacing: 10,
                  children: List.generate(6, (index) {
                    final value = index + 1;
                    return _numberChip(value, provider.noticePeriod ?? 0, () {
                      provider.togglePeriod(value);
                    });
                  }),
                ),

                const SizedBox(height: 24),

                /// Lock-in Period
                _sectionTitle("Lock in Period"),
                Wrap(
                  spacing: 10,
                  children: [
                    _choiceChip("None", provider.lockPerdiod, (_) {
                      provider.toggleLockPeriod("None");
                    }),
                    _choiceChip("Custom", provider.lockPerdiod, (_) {
                      provider.toggleLockPeriod("Custom");
                    }),
                  ],
                ),

                const SizedBox(height: 32),

                /// Buttons
                AppButton(
                  text: "Save & Next",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddressDetailsPage(path: "PG"),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),

                AppButton(
                  text: "Cancel",
                  onTap: () {},
                  textColor: AppColors.black,
                  backgroundColor: AppColors.red.shade100,
                ),

                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  /// ================= Widgets =================

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: textStyle15(FontWeight.w600)),
    );
  }

  Widget _choiceChip(String label, String selected, Function(String) onTap) {
    final bool isSelected = label == selected;
    return GestureDetector(
      onTap: () => onTap(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? AppColors.mainColors : Colors.grey.shade300,
          ),
          color: isSelected
              ? AppColors.mainColors.withOpacity(.1)
              : Colors.white,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.mainColors : Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _checkTile(String title, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: (v) => onChanged(v ?? false)),
        Expanded(child: Text(title)),
      ],
    );
  }

  Widget _numberChip(int value, int isSelected, VoidCallback onTap) {
    final bool selected = isSelected == value;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? AppColors.mainColors : Colors.grey.shade300,
          ),
          color: selected ? AppColors.mainColors.withOpacity(.1) : Colors.white,
        ),
        child: Text(
          value.toString(),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.mainColors : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}

Widget boolChoiceChip(String label, bool isSelected, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: isSelected ? AppColors.mainColors : Colors.grey.shade300,
        ),
        color: isSelected ? AppColors.mainColors.withOpacity(.1) : Colors.white,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.mainColors : Colors.grey.shade700,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
