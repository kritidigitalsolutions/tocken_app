import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/utils/textfield.dart';
import 'package:token_app/view/post_property_page/address_details_page.dart';
import 'package:token_app/view/post_property_page/amenities_page.dart';
import 'package:token_app/view/post_property_page/co_living_pages/profile_details_page.dart';
import 'package:token_app/view/post_property_page/pg_pages/pg_details.dart';
import 'package:token_app/view/post_property_page/pg_pages/pg_price.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/co_living_provider.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/pg_provider.dart';

class RoomDetailsPage extends StatelessWidget {
  final String needFor;
  final bool isSharing;
  const RoomDetailsPage({
    super.key,
    required this.needFor,
    required this.isSharing,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Room Details", style: textStyle17(FontWeight.bold)),
            Text("Co-living > $needFor", style: textStyle13(FontWeight.bold)),
          ],
        ),

        actions: [TextButton(onPressed: () {}, child: const Text("Help"))],
      ),
      body: Consumer<CoLivingProvider>(
        builder: (context, p, _) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label("Available from *"),
                      InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                            initialDate: DateTime.now(),
                          );
                          if (date != null) {
                            p.availableFrom =
                                "${date.day}/${date.month}/${date.year}";
                          }
                        },
                        child: InputDecorator(
                          decoration: _inputDecoration(
                            suffix: const Icon(Icons.calendar_today),
                          ),
                          child: Text(
                            p.availableFrom == null
                                ? "Select date"
                                : "${p.availableFrom}",
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                      _label("BHK *"),
                      Wrap(
                        spacing: 8,
                        children: p.bhkOptions.map((e) {
                          return choiceChip(e, p.bhk ?? '', (_) => p.setBhk(e));
                        }).toList(),
                      ),

                      const SizedBox(height: 20),
                      _label("Furnish Type *"),
                      _dropdown(p.furnishType, p.furnishTypes, (value) {
                        p.setFurnishType(value);

                        if (p.canOpenFurnishing) {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (_) => const FurnishingBottomSheet(),
                          );
                        }
                      }),
                      if (p.furnishType == "Fully Furnished")
                        Column(
                          children: [
                            Text(
                              'Please select 6 amenities',
                              style: textStyle14(
                                FontWeight.w500,
                                color: AppColors.mainColors,
                              ),
                            ),
                            AppButton(
                              text: "Select Amenities",
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (_) => const FurnishingBottomSheet(),
                                );
                              },
                            ),
                          ],
                        ),

                      if (p.furnishType == "Semi Furnished")
                        Column(
                          children: [
                            Text(
                              'Please select 3 amenities',
                              style: textStyle14(
                                FontWeight.w500,
                                color: AppColors.mainColors,
                              ),
                            ),
                            AppButton(
                              text: "Select Amenities",
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                        0.7,
                                  ),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (_) => const FurnishingBottomSheet(),
                                );
                              },
                            ),
                          ],
                        ),

                      const SizedBox(height: 20),
                      _label("Room details"),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: p.roomDetailOptions.map((e) {
                          return boolChoiceChip(
                            e,
                            p.roomDetails.contains(e),
                            () => p.toggleRoomDetail(e),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _label("Total Floor"),
                                AppNumberField(
                                  controller: p.totalFloorsCtrl,
                                  hintText: "Total floor",
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _label("Your Floor"),
                                AppNumberField(
                                  controller: p.yourFloorCtrl,
                                  hintText: "Your floor",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      selectTile(
                        title: "Amenities",
                        subtitle: "Please choose your Amenities",
                        list: p.selectedAmenityModel(amenitiesList),
                        onTap: () {
                          openAmenitiesBottomSheet(
                            context,
                            "Select the Amenities",
                            amenitiesList,
                          );
                        },
                      ),
                      AppButton(
                        text: "Save & Next",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddressDetailsPage(
                                path: "CO-LIVING",
                                isSharing: isSharing,
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
                    ],
                  ),
                ),
              ),

              /// ACTION BUTTONS
            ],
          );
        },
      ),
    );
  }

  // ---------------- Widgets ----------------

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
  );

  Widget _dropdown(
    String? value,
    List<String> items,
    Function(String) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      hint: const Text("Select"),
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (v) => onChanged(v!),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  InputDecoration _inputDecoration({Widget? suffix}) {
    return InputDecoration(
      suffixIcon: suffix,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
    );
  }
}

void openAmenitiesBottomSheet(
  BuildContext context,
  String header,
  List<AmenityModel> list,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return Consumer<CoLivingProvider>(
        builder: (context, provider, child) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                const SizedBox(height: 16),

                /// Title
                Text(
                  header,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                /// Grid
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.9,
                        ),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return GestureDetector(
                        onTap: () {
                          provider.toggleItem(list, index);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 64,
                              width: 64,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: item.isSelected
                                      ? AppColors.mainColors
                                      : Colors.grey.shade300,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Image.asset(
                                  item.icon,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.error_outline);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: item.isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                /// Done Button
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppButton(
                    text: "Done",
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
