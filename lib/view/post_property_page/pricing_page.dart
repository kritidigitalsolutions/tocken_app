import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/utils/textfield.dart';
import 'package:token_app/view/post_property_page/address_details_page.dart';
import 'package:token_app/view/post_property_page/co_living_pages/profile_details_page.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/pg_provider.dart';

class PricingPage extends StatefulWidget {
  final String? propertyType;
  final String? type;
  final bool? isSell;
  const PricingPage({super.key, this.propertyType, this.isSell, this.type});

  @override
  State<PricingPage> createState() => _PricingPageState();
}

class _PricingPageState extends State<PricingPage> {
  final TextEditingController amountCtr = TextEditingController();

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
              "${widget.type} > ${widget.propertyType}",
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

      body: Consumer<PgDetailsProvider>(
        builder: (context, p, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 Rent / Lease
                if (!(widget.isSell ?? false)) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("You're going to ? *"),
                      Wrap(
                        spacing: 10,
                        children: p.rentTypeList
                            .map(
                              (type) => choiceChip(
                                type,
                                p.rentType,
                                (_) => p.setRentType(type),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 20),

                      if (p.rentType == "Only Lease") ...[
                        _sectionTitle("No.of years to Lease *"),
                        Wrap(
                          spacing: 10,
                          children: List.generate(6, (index) {
                            final actualValue = (index + 1).toString();
                            final displayText = (index == 5)
                                ? "6+"
                                : actualValue;

                            return _stringNumberChip(
                              displayText, // label
                              actualValue, // stored value
                              p.leaseYear ?? '',
                              () {
                                p.setLeaseYear(actualValue);
                              },
                            );
                          }),
                        ),
                        SizedBox(height: 15),
                        _sectionTitle("Lease Amount *"),
                        AppNumberField(
                          controller: p.leaseCtr,
                          hintText: "Enter Lease amouunt",
                          icon: Icon(Icons.currency_rupee_sharp),
                        ),
                        SizedBox(height: 15),
                      ],

                      /// 🔹 Rent Amount
                      if (p.rentType != "Only Lease") ...[
                        _sectionTitle("Rent Amount *"),
                        AppNumberField(
                          controller: p.rentCtr,
                          hintText: "Enter rent amouunt",
                          icon: Icon(Icons.currency_rupee_sharp),
                        ),

                        const SizedBox(height: 12),
                      ],
                    ],
                  ),
                ],

                /// sell apartment
                if ((widget.isSell ?? false)) ...[
                  _sectionTitle("Expected Price (All inclusive price) *"),
                  AppNumberField(
                    controller: p.rentCtr,
                    hintText: "Enter expected price",
                    icon: Icon(Icons.currency_rupee_sharp),
                  ),

                  const SizedBox(height: 12),
                ],

                /// 🔹 Add More Pricing
                GestureDetector(
                  onTap: () => _openMorePricingSheet(context, p),
                  child: Text(
                    "+ Add More Pricing Details",
                    style: TextStyle(
                      color: AppColors.mainColors,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// 🔹 Checkboxes
                _checkTile(
                  "Is the price negotiable?",
                  p.negotiable,
                  (v) => p.toggleNegotiable(v),
                ),

                _checkTile(
                  "Is electricity charges included?",
                  p.utilitiesIncluded,
                  (v) => p.toggleutilitiesIncludede(v),
                ),
                if (p.rentType != "Only Lease") ...[
                  if (!(widget.isSell ?? false)) ...[
                    const SizedBox(height: 20),
                    if (widget.propertyType == "COM") ...[
                      _sectionTitle("Yearly rent is expected to increase by *"),
                      AppNumberField(
                        controller: p.leaseCtr,
                        hintText: "% increase by",
                      ),
                      const SizedBox(height: 10),
                    ],

                    /// 🔹 Security Deposit
                    _sectionTitle("Security Deposit"),
                    Wrap(
                      spacing: 10,
                      children: p.securityDeposit
                          .map(
                            (dep) => choiceChip(
                              dep,
                              p.securityDep ?? '',
                              (_) => p.setSecurityDep(dep),
                            ),
                          )
                          .toList(),
                    ),

                    if (p.securityDep == "Fixed") ...[
                      const SizedBox(height: 10),
                      AppTextField(
                        controller: p.fixedCtr,
                        hintText: "Enter fixed deposit amount",
                        prefixIcon: const Icon(Icons.currency_rupee_sharp),
                      ),
                    ],

                    if (p.securityDep == "Multiple of Rent") ...[
                      const SizedBox(height: 10),
                      AppTextField(
                        controller: p.MultiRentCtr,
                        hintText: "Enter no. of months (max 36)",
                        prefixIcon: const Icon(Icons.currency_rupee_sharp),
                      ),
                    ],

                    const SizedBox(height: 20),

                    /// 🔹 Notice Period
                    if (widget.propertyType != "Retail Shop" &&
                        widget.propertyType != "Showroom" &&
                        widget.propertyType != "Warehouse" &&
                        widget.propertyType != "Others") ...[
                      _sectionTitle("Notice Period (in months)"),
                      Wrap(
                        spacing: 10,
                        children: List.generate(6, (index) {
                          final value = index + 1;
                          return _numberChip(value, p.noticePeriod ?? 0, () {
                            p.togglePeriod(value);
                          });
                        }),
                      ),

                      const SizedBox(height: 20),

                      /// 🔹 Lock-in Period
                      _sectionTitle("Lock in Period"),
                      Wrap(
                        spacing: 10,
                        children: [
                          _choiceChip("None", p.LockPerdiod, (_) {
                            p.toggleLockPeriod("None");
                          }),
                          _choiceChip("Custom", p.LockPerdiod, (_) {
                            p.toggleLockPeriod("Custom");
                          }),
                        ],
                      ),
                    ],
                  ],
                ],

                if (widget.type != "Rent")
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Is it Hot Deal",
                              style: textStyle14(FontWeight.bold),
                            ),
                            Icon(Icons.help_outline),
                          ],
                        ),
                        Spacer(),
                        Switch(
                          value: p.isHotDeal,
                          onChanged: (v) {
                            p.toggleHotDeal(v);
                          },
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 32),

                /// Save Button
                AppButton(
                  text: "Save & Next",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddressDetailsPage(
                          path: widget.propertyType ?? '',
                          isSell: widget.isSell,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 15),
                AppButton(
                  text: "Cancel",
                  onTap: () {},
                  textColor: AppColors.black,
                  backgroundColor: AppColors.red.shade100,
                ),
                SizedBox(height: 20),
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

  void _openMorePricingSheet(BuildContext context, PgDetailsProvider p) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Text(
                "Add more Pricing Details",
                style: textStyle15(FontWeight.bold),
              ),

              const SizedBox(height: 16),
              AppNumberField(
                controller: p.maintenanceCtrl,
                hintText: "Maintenance charges (per month)",
                icon: Icon(Icons.currency_rupee_sharp),
              ),

              const SizedBox(height: 12),
              AppNumberField(
                controller: p.bookingCtrl,
                hintText: "Booking amount",
                icon: Icon(Icons.currency_rupee_sharp),
              ),

              const SizedBox(height: 12),
              AppNumberField(
                controller: p.otherCtrl,
                hintText: "Other charges",
                icon: Icon(Icons.currency_rupee_sharp),
              ),

              const SizedBox(height: 20),
              AppButton(text: "Done", onTap: () => Navigator.pop(context)),
            ],
          ),
        );
      },
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

  Widget _checkTile(String text, bool value, ValueChanged<bool> onChanged) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(text),
      value: value,
      activeColor: AppColors.mainColors,
      onChanged: (v) => onChanged(v!),
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

  Widget _stringNumberChip(
    String label,
    String value,
    String isSelected,
    VoidCallback onTap,
  ) {
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
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.mainColors : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
