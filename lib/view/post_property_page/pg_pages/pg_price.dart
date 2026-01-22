import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/utils/textfield.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/pg_provider.dart';

class PgPrice extends StatefulWidget {
  const PgPrice({super.key});

  @override
  State<PgPrice> createState() => _PgPriceState();
}

class _PgPriceState extends State<PgPrice> {
  /// Controllers
  final TextEditingController rentCtr = TextEditingController();
  final TextEditingController mealAmountCtr = TextEditingController();

  /// Chip selections (IMPORTANT: separate values)
  String serviceType = "";
  String mealsAvailable = "";
  String mealType = "";
  String mealTime = "";

  int noticePeriod = 1;
  bool negotiable = false;
  bool utilitiesIncluded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
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
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
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
                              _boolChoiceChip(
                                "Fixed",
                                provider.getSecurityType(room) ==
                                    SecurityDepositType.fixed,
                                () => provider.setSecurityType(
                                  room,
                                  SecurityDepositType.fixed,
                                ),
                              ),
                              _boolChoiceChip(
                                "Multiple of Rent",
                                provider.getSecurityType(room) ==
                                    SecurityDepositType.multiple,
                                () => provider.setSecurityType(
                                  room,
                                  SecurityDepositType.multiple,
                                ),
                              ),
                              _boolChoiceChip(
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
                              controller: provider.fixedDepositCtr[room]!,
                              hintText: "Enter fixed deposit amount",
                              prefixIcon: const Icon(
                                Icons.currency_rupee_sharp,
                              ),
                            ),
                          ],

                          if (securityType == SecurityDepositType.multiple) ...[
                            const SizedBox(height: 10),
                            AppTextField(
                              controller: provider.fixedDepositCtr[room]!,
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
                  negotiable,
                  (v) => setState(() => negotiable = v),
                ),
                _checkTile(
                  "Is electricity and water charge included?",
                  utilitiesIncluded,
                  (v) => setState(() => utilitiesIncluded = v),
                ),

                const SizedBox(height: 24),

                /// Included Services
                _sectionTitle("Select Included Services"),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(provider.serviceList.length, (index) {
                    final service = provider.serviceList[index];
                    return _boolChoiceChip(
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
                    _choiceChip("Yes", mealsAvailable, (v) {
                      setState(() => mealsAvailable = v);
                    }),
                    _choiceChip("No", mealsAvailable, (v) {
                      setState(() => mealsAvailable = v);
                    }),
                    _choiceChip("Extra fees apply", mealsAvailable, (v) {
                      setState(() => mealsAvailable = v);
                    }),
                  ],
                ),

                const SizedBox(height: 24),

                /// Meal Type
                _sectionTitle("Meals Type"),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _choiceChip("Only Veg", mealType, (v) {
                      setState(() => mealType = v);
                    }),
                    _choiceChip("Veg & Non Veg", mealType, (v) {
                      setState(() => mealType = v);
                    }),
                  ],
                ),

                const SizedBox(height: 24),

                /// Meal Time
                _sectionTitle("Meals Availability on Weekdays? *"),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _choiceChip("Breakfast", mealTime, (v) {
                      setState(() => mealTime = v);
                    }),
                    _choiceChip("Lunch", mealTime, (v) {
                      setState(() => mealTime = v);
                    }),
                    _choiceChip("Dinner", mealTime, (v) {
                      setState(() => mealTime = v);
                    }),
                  ],
                ),

                const SizedBox(height: 24),

                /// Meal Amount
                _sectionTitle("Meal Amount *"),
                AppTextField(
                  controller: mealAmountCtr,
                  hintText: "Enter meal amount",
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(FontAwesomeIcons.rupeeSign),
                ),

                const SizedBox(height: 24),

                /// Notice Period
                _sectionTitle("Notice Period (in months)"),
                Wrap(
                  spacing: 10,
                  children: List.generate(6, (index) {
                    final value = index + 1;
                    return _numberChip(value);
                  }),
                ),

                const SizedBox(height: 24),

                /// Lock-in Period
                _sectionTitle("Lock in Period"),
                Wrap(
                  spacing: 10,
                  children: [
                    _choiceChip("None", "", (_) {}),
                    _choiceChip("Custom", "", (_) {}),
                  ],
                ),

                const SizedBox(height: 32),

                /// Buttons
                AppButton(text: "Save & Next", onTap: () {}),

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

  Widget _boolChoiceChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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

  Widget _numberChip(int value) {
    final bool selected = noticePeriod == value;
    return GestureDetector(
      onTap: () => setState(() => noticePeriod = value),
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
