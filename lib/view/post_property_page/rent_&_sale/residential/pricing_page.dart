import 'package:flutter/material.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/post_property_page/rent_&_sale/residential/amenities_page.dart';

class PricingPage extends StatefulWidget {
  const PricingPage({super.key});

  @override
  State<PricingPage> createState() => _PricingPageState();
}

class _PricingPageState extends State<PricingPage> {
  String rentType = "Only Rent";
  String securityType = "Fixed";
  int noticePeriod = 1;

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
              "Pricing Details",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              "Rent > Residential > Apartment",
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Path

            /// 🔹 Rent / Lease
            _sectionTitle("You're going to ? *"),
            Row(
              children: [
                _choiceChip("Only Rent", rentType, (v) {
                  setState(() => rentType = v);
                }),
                const SizedBox(width: 10),
                _choiceChip("Only Lease", rentType, (v) {
                  setState(() => rentType = v);
                }),
              ],
            ),

            const SizedBox(height: 20),

            /// 🔹 Rent Amount
            _sectionTitle("Rent Amount *"),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter rent amount",
                suffixIcon: Icon(Icons.currency_rupee),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// 🔹 Add More Pricing
            Text(
              "+ Add More Pricing Details",
              style: TextStyle(
                color: AppColors.mainColors,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 16),

            /// 🔹 Checkboxes
            _checkTile("Is the price negotiable ?"),
            _checkTile("Is electricity and water charge included?"),

            const SizedBox(height: 20),

            /// 🔹 Security Deposit
            _sectionTitle("Security Deposit"),
            Wrap(
              spacing: 10,
              children: [
                _choiceChip("Fixed", securityType, (v) {
                  setState(() => securityType = v);
                }),
                _choiceChip("Multiple of rents", securityType, (v) {
                  setState(() => securityType = v);
                }),
                _choiceChip("None", securityType, (v) {
                  setState(() => securityType = v);
                }),
              ],
            ),

            const SizedBox(height: 20),

            /// 🔹 Notice Period
            _sectionTitle("Notice Period (in months)"),
            Wrap(
              spacing: 10,
              children: List.generate(6, (index) {
                final value = index + 1;
                return _numberChip(value);
              }),
            ),

            const SizedBox(height: 20),

            /// 🔹 Lock-in Period
            _sectionTitle("Lock in Period"),
            Wrap(
              spacing: 10,
              children: [
                _choiceChip("None", "", (_) {}),
                _choiceChip("Custom", "", (_) {}),
              ],
            ),

            const SizedBox(height: 32),

            /// Save Button
            AppButton(
              text: "Save & Next",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ContactAmenitiesPage()),
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

  Widget _checkTile(String title) {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (_) {}),
        Expanded(child: Text(title)),
      ],
    );
  }

  Widget _numberChip(int value) {
    final bool selected = noticePeriod == value;
    return GestureDetector(
      onTap: () {
        setState(() => noticePeriod = value);
      },
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
