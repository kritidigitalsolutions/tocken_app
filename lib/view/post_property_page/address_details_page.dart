import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/app_snackbar.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/helper/helper_method.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/utils/textfield.dart';
import 'package:token_app/view/home_screen/location_screen.dart';
import 'package:token_app/view/post_property_page/amenities_page.dart';
import 'package:token_app/view/post_property_page/co_living_pages/pricing_details_page.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/pg_provider.dart';

class AddressDetailsPage extends StatelessWidget {
  final String path;
  final String? type;
  final String? proClasses;
  final bool? isSharing;
  final bool? isSell;
  const AddressDetailsPage({
    super.key,
    required this.path,
    this.isSharing,
    this.type,
    this.proClasses,
    this.isSell,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PgDetailsProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: const BackButton(),
        title: Text('Address Details', style: textStyle17(FontWeight.w900)),
        actions: [TextButton(onPressed: () {}, child: const Text("Help"))],
      ),
      body: SafeArea(
        child: Form(
          key: provider.addressKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// CITY
                      _label('City *'),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  LocationScreen(path: "CITY_ADDRESS"),
                            ),
                          );
                        },
                        child: AbsorbPointer(
                          child: AppTextField(
                            fillColor: AppColors.white,
                            filled: true,
                            controller: provider.cityCtr,
                            hintText: 'Enter name of the city/town',
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter your City";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),

                      //   if (provider.isCitySelected) ...[
                      const SizedBox(height: 20),

                      _label('Locality *'),
                      AppTextField(
                        fillColor: AppColors.white,
                        filled: true,
                        controller: provider.localityCtr,
                        hintText: 'Enter the locality',
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your Locality";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      _label('Building/Society'),
                      AppTextField(
                        fillColor: AppColors.white,
                        filled: true,
                        controller: provider.addressCtr,
                        hintText: 'Enter your society or area',
                      ),
                      //  ],
                      const SizedBox(height: 40),
                      _orDivider(),
                      const SizedBox(height: 40),

                      /// USE CURRENT LOCATION
                      // if (!provider.isCitySelected)
                      OutlinedButton.icon(
                        onPressed: () async {
                          showLoadingOverlay(
                            context,
                            message: "Fetching your location...",
                          );

                          try {
                            final locationData =
                                await getCurrentLocationAndAddress(context);

                            // Success - you can now use the data
                            print(locationData['address']);
                            print(locationData['city']);
                            provider.cityCtr.text = locationData['city'];
                            provider.localityCtr.text =
                                locationData['locality'];

                            // Optional: show success message or set location in provider
                            AppSnackBar.success(
                              context,
                              "Your current location has been set.",
                            );
                          } catch (e) {
                            // Handle error
                            AppSnackBar.error(
                              context,
                              "Failed to get location: $e",
                            );
                          } finally {
                            // Always hide loader
                            hideLoadingOverlay(context);
                          }
                        },
                        icon: const Icon(Icons.my_location),
                        label: const Text("Use My Current Location"),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// SAVE BUTTON
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: AppButton(
                  text: "Save & Next",
                  onTap: () {
                    if (provider.addressKey.currentState!.validate()) {
                      if (path == "CO-LIVING") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PricingDetailsPage(
                              isSharing: isSharing ?? false,
                            ),
                          ),
                        );
                      } else if (path == "COM") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ContactAmenitiesPage(
                              propertyType: path,
                              type: type,
                              proClasses: proClasses,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ContactAmenitiesPage(
                              propertyType: path,
                              isSell: isSell,
                              type: type,
                              proClasses: proClasses,
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: AppButton(
                  text: "Cancel",
                  onTap: () {},
                  textColor: AppColors.black,
                  backgroundColor: AppColors.red.shade100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------- Widgets ----------

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _orDivider() {
    return Row(
      children: const [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text("OR"),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}
