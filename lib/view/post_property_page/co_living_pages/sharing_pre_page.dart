import 'package:flutter/material.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/view/post_property_page/co_living_pages/other_details_page.dart';

class SharingPreferencePage extends StatefulWidget {
  const SharingPreferencePage({super.key});

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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sharing Preference",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              "Co-living > Need Room/Flat",
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

      /// BODY
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Preferred Gender
            _label("Preferred Partner Gender *"),
            const SizedBox(height: 10),
            Row(children: [_chip("Male"), _chip("Female"), _chip("Any")]),

            const SizedBox(height: 24),

            /// Age Limit
            _label("Partner Age limit *"),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _dropdown(minAge, (v) => setState(() => minAge = v)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _dropdown(maxAge, (v) => setState(() => maxAge = v)),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// Occupation
            _label("Partner Occupation *"),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              children: [
                _occupationChip("Student"),
                _occupationChip("Working Professional"),
                _occupationChip("Other"),
              ],
            ),

            const SizedBox(height: 24),

            /// Preferences Box
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Preferences",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Please choose your Preferences",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.add_circle_outline, color: Colors.blue),
                    const SizedBox(width: 6),
                    const Text(
                      "Select",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => OtherDetailsPage()),
                );
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
      ),
    );
  }

  /// ---------------- Widgets ----------------

  Widget _label(String text) {
    return Text(text, style: const TextStyle(fontWeight: FontWeight.w600));
  }

  Widget _chip(String value) {
    final bool selected = selectedGender == value;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ChoiceChip(
        label: Text(value),
        selected: selected,
        onSelected: (_) => setState(() => selectedGender = value),
        selectedColor: AppColors.mainColors.withAlpha(100),
      ),
    );
  }

  Widget _occupationChip(String value) {
    final bool selected = selectedOccupation == value;
    return ChoiceChip(
      label: Text(value),
      selected: selected,
      onSelected: (_) => setState(() => selectedOccupation = value),
      selectedColor: AppColors.mainColors.withAlpha(100),
    );
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
