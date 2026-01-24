import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/post_property_page/pg_pages/pg_price.dart';
import 'package:token_app/view/post_property_page/photo_upload_page.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/pg_provider.dart';

class ContactAmenitiesPage extends StatefulWidget {
  final String? propertyType;
  final bool? isSell;
  const ContactAmenitiesPage({super.key, this.propertyType, this.isSell});

  @override
  State<ContactAmenitiesPage> createState() => _ContactAmenitiesPageState();
}

class _ContactAmenitiesPageState extends State<ContactAmenitiesPage> {
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
              "Contact & Amenities",
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

      body: Consumer<PgDetailsProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              /// 🔹 Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Phone Number
                      _sectionTitle("Phone Number *"),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.grey.shade300,
                          border: Border.all(color: AppColors.grey.shade400),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/auth/india_flag.png",
                              height: 20,
                            ),
                            const SizedBox(width: 6),
                            Text("(+91) 9999999999"),
                            const Spacer(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// Hide Number Switch
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Keep my phone number private"),
                          Switch(
                            value: provider.hideNumber,
                            onChanged: (v) {
                              provider.toggleHideNumber(v);
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      /// Info Text
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 18,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Turning on the switch keeps your number private, "
                              "though leads can reach you through Request Callback Option.",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      /// Amenities
                      selectTile(
                        title: "Amenities",
                        subtitle: "Please choose your Amenities",
                        list: provider.selectedAmenityModel(amenitiesList),
                        onTap: () {
                          _openAmenitiesBottomSheet(
                            context,
                            "Select the Amenities",
                            amenitiesList,
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      /// Preferences
                      if (widget.propertyType != "COM" &&
                          widget.propertyType != "Retail Shop" &&
                          widget.propertyType != "Showroom" &&
                          widget.propertyType != "Warehouse" &&
                          widget.propertyType != "Others" &&
                          !(widget.isSell ?? true))
                        selectTile(
                          title: widget.propertyType != "PG"
                              ? "Preferences"
                              : "PG Rules",
                          subtitle: "Please choose your Preferences",
                          list: provider.selectedAmenityModel(preferencesList),
                          onTap: () {
                            _openAmenitiesBottomSheet(
                              context,
                              "Select the Preferences",
                              preferencesList,
                            );
                          },
                        ),

                      if (widget.propertyType == "PG") ...[
                        _sectionTitle("Last Entry Time"),
                        _dropdown(
                          provider.lastEntryTime,
                          provider.entryTimeList,
                          (val) {
                            provider.toggleEntryTime(val);
                          },
                        ),
                        SizedBox(height: 15),
                        _sectionTitle("Common Areas"),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: provider.commonAreaList.map((area) {
                            return boolChoiceChip(
                              area,
                              provider.isSelectedArea(area),
                              () {
                                provider.toggelArea(area);
                              },
                            );
                          }).toList(),
                        ),
                      ],

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),

              /// 🔹 Bottom Buttons
              /// Save Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: AppButton(
                  text: "Save & Next",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PhotosPage()),
                    );
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
              SizedBox(height: 15),
            ],
          );
        },
      ),
    );
  }

  /// ================== Widgets ==================

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
      onChanged: (v) {},
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(title, style: textStyle15(FontWeight.w600)),
    );
  }
}

Widget selectTile({
  required String title,
  required String subtitle,
  required List<AmenityModel> list,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: textStyle14(FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              Icon(Icons.add_circle_outline, color: AppColors.mainColors),
              const SizedBox(width: 6),
              Text(
                "Select",
                style: TextStyle(
                  color: AppColors.mainColors,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (list.isNotEmpty) ...[
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: list.map((item) {
                return Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Image.asset(
                        item.icon,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error_outline);
                        },
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    ),
  );
}

void _openAmenitiesBottomSheet(
  BuildContext context,
  String header,
  List<AmenityModel> list,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return Consumer<PgDetailsProvider>(
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
