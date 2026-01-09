import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/viewModel/afterLogin/account_pages_provider/account_pages_provider.dart';

class DirectLeads extends StatelessWidget {
  const DirectLeads({super.key});

  static const leadTypes = ["Buyers", "Renters", "Both"];
  static const propertyTypes = [
    "Apartment",
    "Individual Floor",
    "Independent House",
    "Farm House",
    "Villa",
    "Duplex",
    "Service Apartments",
    "Penthouse",
    "1RK/Studio House",
    "Office Space",
    "Warehouse",
    "Retail Shop",
    "Industrial Sheds",
    "Showroom",
    "Plot/Land",
    "Argicultural Land",
    "Factory & Manufacturing",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DirectLeadsProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        title: Text(
          "Request Direct Leads",
          style: textStyle17(FontWeight.w900),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Leads Type
            _title("Leads Type *"),
            Wrap(
              spacing: 12,
              children: leadTypes.map((e) {
                return _choiceChip(
                  text: e,
                  selected: provider.leadType == e,
                  onTap: () => provider.selectLeadType(e),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            /// 🔹 Cities
            _title("Dealing Cities *"),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Search City",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.my_location),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onTap: () => provider.addCity("Agra"),
            ),

            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: provider.cities
                  .map(
                    (city) => Chip(
                      label: Text(city),
                      deleteIcon: const Icon(Icons.close),
                      onDeleted: () => provider.removeCity(city),
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 24),

            /// 🔹 Property Type
            _title("Dealing Property Type *"),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: propertyTypes.map((e) {
                return _choiceChip(
                  text: e,
                  selected: provider.propertyTypes.contains(e),
                  onTap: () => provider.toggleProperty(e),
                );
              }).toList(),
            ),

            SizedBox(height: 20),
            AppButton(text: "Send Request", onTap: () {}),
          ],
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _choiceChip({
    required String text,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ? AppColors.mainColors : Colors.grey.shade400,
          ),
          color: AppColors.white,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? AppColors.mainColors : Colors.black,
          ),
        ),
      ),
    );
  }
}
