import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/textfield.dart';
import 'package:token_app/view/post_property_page/preview_property_page.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/post_propert_providers.dart';

class AddressDetailsPage extends StatelessWidget {
  const AddressDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AddressDetailsProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          'Location & Media',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// STEP INDICATOR
            Container(
              decoration: BoxDecoration(color: AppColors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _stepBar(active: true),
                        _stepBar(active: true),
                        _stepBar(),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Step 2 of 3',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(color: AppColors.white),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.location_on_outlined, color: Colors.red),
                            SizedBox(width: 6),
                            Text(
                              'Location Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        /// City
                        _label('City'),
                        CustomDropdown(
                          value: provider.city,
                          hint: 'Select City',
                          items: const [
                            'Mumbai',
                            'Delhi',
                            'Bangalore',
                            'Utter Pradesh',
                            'Kolkata',
                          ],
                          borderColor: AppColors.grey,
                          focusedBorderColor: AppColors.mainColors,
                          onChanged: (value) {
                            provider.setCity(value ?? '');
                          },
                        ),
                        const SizedBox(height: 16),

                        /// Locality
                        _label('Locality'),
                        AppTextField(
                          controller: provider.localityCtr,
                          hintText: 'e.g., Andheri West',
                        ),

                        const SizedBox(height: 16),

                        /// Full Address
                        _label('Full Address'),
                        AppTextField(
                          maxLines: 3,
                          controller: provider.addressCtr,
                          hintText: 'Enter complete address',
                        ),

                        const SizedBox(height: 20),

                        /// Map Preview
                        Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 40,
                                color: Colors.red,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Map Preview',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            /// Continue Button
            ///
            Selector<AddressDetailsProvider, bool>(
              selector: (_, p) => p.isFormValid,
              builder: (context, value, child) {
                return Container(
                  decoration: BoxDecoration(color: AppColors.white),
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: AppButton(
                      text: "Continue to Preview",
                      onTap: !value
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PreviewPropertyScreen(),
                                ),
                              );
                            },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  // ---------- Widgets ----------
  Widget _stepBar({bool active = false}) {
    return Expanded(
      child: Container(
        height: 4,
        margin: const EdgeInsets.only(right: 6),
        decoration: BoxDecoration(
          color: active ? Colors.red : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
