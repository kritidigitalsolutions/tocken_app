import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/post_property_page/amenities_page.dart';
import 'package:token_app/view/post_property_page/co_living_pages/other_details_page.dart';
import 'package:token_app/view/post_property_page/co_living_pages/profile_details_page.dart';
import 'package:token_app/view/post_property_page/co_living_pages/room_details_page.dart';
import 'package:token_app/view/post_property_page/pg_pages/pg_price.dart';
import 'package:token_app/view/post_property_page/photo_upload_page.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/co_living_provider.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/pg_provider.dart';

class SharingPreferencePage extends StatefulWidget {
  final bool isSharing;
  const SharingPreferencePage({super.key, required this.isSharing});

  @override
  State<SharingPreferencePage> createState() => _SharingPreferencePageState();
}

class _SharingPreferencePageState extends State<SharingPreferencePage> {
  String selectedGender = "Male";
  String selectedOccupation = "Student";

  String minAge = "18 years";
  String maxAge = "60 years";

  final List<String> ageList = List.generate(60, (i) => "${i + 18} years");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// APP BAR
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: const BackButton(),
        title: Text("Sharing Preference", style: textStyle17(FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextAppButton(text: "Help", onTap: () {}),
          ),
        ],
      ),

      /// BODY
      body: Consumer<CoLivingProvider>(
        builder: (context, p, child) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Preferred Gender
                _label("Preferred Partner Gender *"),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: p.partnerGenderList.map((g) {
                    return choiceChip(g, p.pGender, (g) {
                      p.setPGender(g);
                    });
                  }).toList(),
                ),

                const SizedBox(height: 24),

                /// Age Limit
                _label("Partner Age limit *"),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: _dropdown(p.minAge, (v) => p.setMinAge(v))),
                    const SizedBox(width: 12),
                    Expanded(child: _dropdown(p.maxAge, (v) => p.setMaxAge(v))),
                  ],
                ),

                const SizedBox(height: 24),

                /// Occupation
                _label("Partner Occupation *"),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: p.partnerOccList.map((g) {
                    return boolChoiceChip(g, p.isSelectedPOcc(g), () {
                      p.setPOcc(g);
                    });
                  }).toList(),
                ),

                const SizedBox(height: 24),

                /// Preferences Box
                selectTile(
                  title: "Preferences",

                  subtitle: "Please choose your Preferences",
                  list: p.selectedAmenityModel(preferencesList),
                  onTap: () {
                    openAmenitiesBottomSheet(
                      context,
                      "Select the Preferences",
                      preferencesList,
                    );
                  },
                ),
                const SizedBox(height: 20),

                /// Note
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: "Note: ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text:
                            "This information will help us find you the perfect roommate.",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                SizedBox(height: 20),
                AppButton(
                  text: "Save & Next",
                  onTap: () {
                    if (widget.isSharing) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PhotosPage(isSharing: widget.isSharing),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => OtherDetailsPage()),
                      );
                    }
                  },
                ),
                SizedBox(height: 15),
                AppButton(
                  text: "Cancel",
                  onTap: () {},
                  backgroundColor: AppColors.red.shade100,
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  /// ---------------- Widgets ----------------

  Widget _label(String text) {
    return Text(text, style: const TextStyle(fontWeight: FontWeight.w600));
  }

  Widget _dropdown(String value, Function(String) onChanged) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      items: ageList
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (v) => onChanged(v!),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
