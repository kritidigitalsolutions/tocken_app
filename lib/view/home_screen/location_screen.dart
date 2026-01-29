import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/helper/helper_method.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/viewModel/afterLogin/location_provider.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LocationProvider>();

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
                final locationData = await getCurrentLocationAndAddress(
                  context,
                );
                print(locationData['address']);
                print(locationData['city']);
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
