import 'package:flutter/material.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/post_property_page/address_details_page.dart';
import 'package:token_app/view/post_property_page/photo_upload_page.dart';

class ContactAmenitiesPage extends StatefulWidget {
  final String? propertyType;
  const ContactAmenitiesPage({super.key, this.propertyType});

  @override
  State<ContactAmenitiesPage> createState() => _ContactAmenitiesPageState();
}

class _ContactAmenitiesPageState extends State<ContactAmenitiesPage> {
  bool hideNumber = false;

  List<AmenityModel> amenitiesList = [
    AmenityModel(title: "Lift", icon: "assets/icons/lift.png"),
    AmenityModel(title: "Power Backup", icon: "assets/icons/power.png"),
    AmenityModel(title: "Gym", icon: "assets/icons/gym.png"),
    AmenityModel(title: "Swimming Pool", icon: "assets/icons/pool.png"),
    AmenityModel(title: "CCTV Surveillance", icon: "assets/icons/cctv.png"),
    AmenityModel(title: "Gated Community", icon: "assets/icons/gated.png"),
    AmenityModel(title: "Water Supply", icon: "assets/icons/water.png"),
    AmenityModel(title: "Parking Lot", icon: "assets/icons/parking.png"),
    AmenityModel(title: "Kids Area", icon: "assets/icons/kids.png"),
    AmenityModel(title: "Playground", icon: "assets/icons/playground.png"),
    AmenityModel(title: "Community Garden", icon: "assets/icons/garden.png"),
    AmenityModel(title: "Free Wifi", icon: "assets/icons/wifi.png"),
    AmenityModel(title: "Club", icon: "assets/icons/club.png"),
    AmenityModel(title: "Gas", icon: "assets/icons/gas.png"),
    AmenityModel(title: "Sewage", icon: "assets/icons/sewage.png"),
  ];

  List<AmenityModel> preferencesList = [
    AmenityModel(title: "Bachelor", icon: "assets/icons/lift.png"),
    AmenityModel(title: "Family", icon: "assets/icons/power.png"),
    AmenityModel(title: "Living Couple", icon: "assets/icons/gym.png"),
    AmenityModel(title: "Professional", icon: "assets/icons/pool.png"),
    AmenityModel(title: "No Pets", icon: "assets/icons/cctv.png"),
    AmenityModel(title: "No Smoking", icon: "assets/icons/gated.png"),
    AmenityModel(title: "Student", icon: "assets/icons/water.png"),
    AmenityModel(title: "Guests are allowed", icon: "assets/icons/parking.png"),
    AmenityModel(title: "Only Veg", icon: "assets/icons/gated.png"),
    AmenityModel(title: "Gender Restrictions", icon: "assets/icons/water.png"),
    AmenityModel(title: "No Alcohol", icon: "assets/icons/parking.png"),
  ];

  String? lastEntryTime;

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

      body: Column(
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
                        Image.asset("assets/auth/india_flag.png", height: 20),
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
                        value: hideNumber,
                        onChanged: (v) {
                          setState(() => hideNumber = v);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  /// Info Text
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline, size: 18, color: Colors.grey),
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
                  _selectTile(
                    title: "Amenities",
                    subtitle: "Please choose your Amenities",
                    onTap: () {
                      openAmenitiesBottomSheet(
                        context,
                        "Select the Amenities",
                        amenitiesList,
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  /// Preferences
                  _selectTile(
                    title: widget.propertyType != "PG"
                        ? "Preferences"
                        : "PG Rules",
                    subtitle: "Please choose your Preferences",
                    onTap: () {
                      openAmenitiesBottomSheet(
                        context,
                        "Select the Preferences",
                        preferencesList,
                      );
                    },
                  ),

                  if (widget.propertyType == "PG") ...[
                    _sectionTitle("Last Entry Time"),
                    _dropdown(
                      lastEntryTime,
                      ["10:00 PM", "11:00 PM", "12:00 AM", "No Restriction"],
                      (val) {
                        setState(() {
                          lastEntryTime = val;
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    _sectionTitle("Common Areas"),
                    Wrap(
                      spacing: 10,
                      children: [
                        _choiceChip("Living Room", "", (_) {}),
                        _choiceChip("Kitchen", "", (_) {}),
                        _choiceChip("Dining Hall", "", (_) {}),
                      ],
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
        ],
      ),
    );
  }

  /// ================== Widgets ==================

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

  Widget _selectTile({
    required String title,
    required String subtitle,
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
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textStyle14(FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
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
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
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
                          setState(() {
                            item.isSelected = !item.isSelected;
                          });
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
                                child: Image.asset(item.icon),
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
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColors,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Done",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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

class AmenityModel {
  final String title;
  final String icon; // asset path
  bool isSelected;

  AmenityModel({
    required this.title,
    required this.icon,
    this.isSelected = false,
  });
}
