import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/app_snackbar.dart';
import 'package:token_app/utils/helper/helper_method.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/viewModel/afterLogin/location_provider.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/pg_provider.dart';

class LocationScreen extends StatefulWidget {
  final String? path;
  const LocationScreen({super.key, this.path});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LocationProvider>();
    final postPropertyPro = context.watch<PgDetailsProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, size: 20),
        ),
        title: Text(
          "Enter your city, area or locality address",
          style: textStyle15(FontWeight.w900),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Column(
          children: [
            /// 🔍 Search Field
            TextField(
              controller: searchController,
              onChanged: (value) {
                provider.searchCity(value);
              },
              decoration: InputDecoration(
                hintText: "Search by city, locality, area...",
                hintStyle: textStyle14(FontWeight.w500, color: AppColors.grey),
                prefixIcon: const Icon(Icons.search),
                border: _inputDecoration(),
                focusedBorder: _inputDecoration(),
                enabledBorder: _inputDecoration(),
              ),
            ),

            const SizedBox(height: 15),

            GestureDetector(
              onTap: () async {
                final pref = await SharedPreferences.getInstance();
                // Show loader
                showLoadingOverlay(
                  context,
                  message: "Fetching your location...",
                );

                try {
                  final locationData = await getCurrentLocationAndAddress(
                    context,
                  );
                  if (widget.path == "USER_CITY") {
                    pref.setString("city", locationData['city']);
                  }
                  if (widget.path == "CITY_ADDRESS") {
                    postPropertyPro.cityCtr.text = locationData['city'];
                    postPropertyPro.localityCtr.text = locationData['locality'];
                    postPropertyPro.addressCtr.text = locationData["address"];
                  }

                  // Success - you can now use the data
                  print(locationData['address']);
                  print(locationData['city']);
                  postPropertyPro.cityCtr.text = locationData['city'];
                  postPropertyPro.localityCtr.text = locationData['locality'];

                  // Optional: show success message or set location in provider
                  AppSnackBar.success(
                    context,
                    "Your current location has been set.",
                  );
                  Navigator.pop(context);
                } catch (e) {
                  // Handle error
                  AppSnackBar.error(context, "Failed to get location: $e");
                } finally {
                  // Always hide loader
                  hideLoadingOverlay(context);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined, color: AppColors.mainColors),
                  const SizedBox(width: 8),
                  Text(
                    'Use my current location',
                    style: textStyle15(
                      FontWeight.bold,
                      color: AppColors.mainColors,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 5),
            Divider(color: AppColors.grey.shade300),

            /// 📍 Result List
            Expanded(
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : provider.locations.data == null
                  ? const Center(child: Text("Search city to see result"))
                  : ListView.builder(
                      itemCount: provider.locations.data!.data.length,
                      itemBuilder: (context, index) {
                        final item = provider.locations.data!.data[index];

                        return ListTile(
                          leading: const Icon(Icons.location_on),
                          title: Text(
                            item.displayName ?? "",
                            style: textStyle15(FontWeight.w600),
                          ),
                          subtitle: Text(
                            item.city ?? "",
                            style: textStyle13(FontWeight.w400),
                          ),
                          onTap: () {
                            if (widget.path == "CITY_ADDRESS") {
                              postPropertyPro.cityCtr.text = item.city ?? '';
                            }
                            Navigator.pop(context);
                            print(item.displayName);
                            print(item.city);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder _inputDecoration() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(width: 1, color: AppColors.grey.shade300),
    );
  }
}

void showLoadingOverlay(BuildContext context, {String? message}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              if (message != null) ...[
                const SizedBox(height: 20),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      );
    },
  );
}

/// Hides the currently shown loading overlay
void hideLoadingOverlay(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  }
}
