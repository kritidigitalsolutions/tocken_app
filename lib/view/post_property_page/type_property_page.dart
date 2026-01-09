import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/post_property_page/property_details_page.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/post_propert_providers.dart';

class TypePropertyPage extends StatelessWidget {
  const TypePropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text("Post Property", style: textStyle17(FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What are you posting?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: const [
                    PropertyTile(icon: Icons.apartment, label: 'Apartment'),
                    PropertyTile(icon: Icons.house, label: 'Bungalow'),
                    PropertyTile(icon: Icons.location_on, label: 'Plot'),
                    PropertyTile(icon: Icons.store, label: 'Commercial'),
                    PropertyTile(icon: Icons.bed, label: 'PG'),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// Continue button enabled only when selected
              Selector<TypePropertyProvider, String?>(
                selector: (_, provider) => provider.selectedType,
                builder: (context, selectedType, _) {
                  return AppButton(
                    text: "Continue",
                    onTap: selectedType == null
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PropertyDetailsPage(
                                  propertyType: selectedType,
                                ),
                              ),
                            );
                          },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PropertyTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const PropertyTile({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Selector<TypePropertyProvider, String?>(
      selector: (_, provider) => provider.selectedType,
      builder: (context, selectedType, _) {
        final bool isSelected = selectedType == label;

        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            context.read<TypePropertyProvider>().selectType(label);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected
                    ? AppColors.mainColors
                    : AppColors.grey.shade300,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12),
              color: AppColors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 36,
                  color: isSelected
                      ? AppColors.mainColors
                      : AppColors.grey.shade700,
                ),
                const SizedBox(height: 10),
                Text(
                  label,
                  style: textStyle15(
                    FontWeight.w500,
                    color: isSelected ? AppColors.mainColors : AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
