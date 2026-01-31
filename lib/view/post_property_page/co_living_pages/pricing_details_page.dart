import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/utils/textfield.dart';
import 'package:token_app/view/post_property_page/co_living_pages/sharing_pre_page.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/co_living_provider.dart';

class PricingDetailsPage extends StatefulWidget {
  final bool isSharing;
  const PricingDetailsPage({super.key, required this.isSharing});

  @override
  State<PricingDetailsPage> createState() => _PricingDetailsPageState();
}

class _PricingDetailsPageState extends State<PricingDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<CoLivingProvider>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: const BackButton(),
        title: Text("Pricing", style: TextStyle(fontWeight: FontWeight.w600)),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextAppButton(text: "Help", onTap: () {}),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: widget.isSharing
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Rent
                  Text("Rent Amount *", style: textStyle14(FontWeight.w600)),
                  const SizedBox(height: 8),
                  AppNumberField(
                    controller: provider.rentCtrl,
                    hintText: "Enter rent",
                    icon: Icon(Icons.currency_rupee_sharp),
                  ),

                  const SizedBox(height: 14),

                  /// Add more pricing
                  GestureDetector(
                    onTap: () => _openMorePricingSheet(context, provider),
                    child: Text(
                      "+ Add More Pricing Details",
                      style: TextStyle(
                        color: AppColors.mainColors,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Checkboxes
                  Selector<CoLivingProvider, bool>(
                    selector: (_, provider) => provider.negotiable,
                    builder: (context, value, child) {
                      return _checkTile(
                        "Is the price negotiable?",
                        value,
                        (v) => provider.toggleNegotiable(v),
                      );
                    },
                  ),

                  Selector<CoLivingProvider, bool>(
                    selector: (_, provider) => provider.utilitiesIncluded,
                    builder: (context, value, child) {
                      return _checkTile(
                        "Is electricity charges included?",
                        value,
                        (v) => provider.toggleutilitiesIncludede(v),
                      );
                    },
                  ),
                  const Spacer(),

                  AppButton(
                    text: "Save & Next",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SharingPreferencePage(
                            isSharing: widget.isSharing,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    text: "Cancel",
                    backgroundColor: AppColors.grey.shade200,
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                ],
              )
            : Column(
                children: [
                  Text("Budget", style: textStyle15(FontWeight.bold)),
                  SizedBox(height: 10),
                  Consumer<CoLivingProvider>(
                    builder: (context, p, child) {
                      return Row(
                        children: [
                          Expanded(
                            child: _dropdown(
                              p.minBudget,
                              p.minBudgetList,
                              (v) => p.setMinBudget(v),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _dropdown(
                              p.maxBudget,
                              p.maxBudgetList,
                              (v) => p.setMaxBudget(v),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Note: The amount mentioned above is what you can pay as rent every month",
                    style: textStyle15(FontWeight.w500),
                  ),
                  const Spacer(),

                  AppButton(
                    text: "Save & Next",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SharingPreferencePage(
                            isSharing: widget.isSharing,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    text: "Cancel",
                    backgroundColor: AppColors.grey.shade200,
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                ],
              ),
      ),
    );
  }

  Widget _dropdown(
    String value,
    List<String> items,
    Function(String) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (v) => onChanged(v!),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

/// Checkbox tile
Widget _checkTile(String text, bool value, ValueChanged<bool> onChanged) {
  return CheckboxListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(text),
    value: value,
    activeColor: AppColors.mainColors,
    onChanged: (v) => onChanged(v!),
  );
}

void _openMorePricingSheet(BuildContext context, CoLivingProvider p) {
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
