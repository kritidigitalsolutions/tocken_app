import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/textfield.dart';
import 'package:token_app/view/post_property_page/address_details_page.dart';
import 'package:token_app/view/post_property_page/co_living_pages/room_details_page.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/co_living_provider.dart';

class ProfileDetailsPage extends StatefulWidget {
  final String needRoom;
  final bool isShare;
  const ProfileDetailsPage({
    super.key,
    required this.isShare,
    required this.needRoom,
  });

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  String? selectedGender;

  bool isPrivate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Profile Details",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              "Co-living > ${widget.needRoom}",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("Help"),
            ),
          ),
        ],
      ),

      body: Consumer<CoLivingProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Profile Image
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundImage: NetworkImage(
                          "https://i.pravatar.cc/300",
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.blue,
                          child: const Icon(
                            Icons.edit,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                /// Name
                _label("Name *"),
                AppTextField(
                  controller: provider.nameCtr,
                  hintText: "Enter your name",
                  filled: true,
                  fillColor: AppColors.background,
                ),

                const SizedBox(height: 20),

                /// Mobile Number
                _label("Mobile Number *"),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: _boxDecoration(),
                  child: Row(
                    children: [
                      const Text("🇮🇳  (+91)"),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: provider.mobileCtr,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                /// Private Switch
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text("Keep my mobile number private"),
                      ),
                      Switch(
                        value: isPrivate,
                        onChanged: (val) {
                          setState(() => isPrivate = val);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),
                Text(
                  "Turning on the switch keeps your number private, though leads can reach you through Request Callback Option.",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),

                const SizedBox(height: 24),

                /// DOB
                _label("Date of Birth *"),
                TextField(
                  controller: provider.dobCtr,
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.calendar_month),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2010),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      provider.dobCtr.text =
                          "${picked.day}/${picked.month}/${picked.year}";
                    }
                  },
                ),

                const SizedBox(height: 24),

                /// Gender (placeholder)
                _label("Gender *"),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: provider.genderList.map((gender) {
                    return choiceChip(gender, provider.gender, (gender) {
                      provider.selectGender(gender);
                    });
                  }).toList(),
                ),

                const SizedBox(height: 24),

                // Occupation
                _label("Occupation *"),
                DropdownTextField<String>(
                  hint: "Select the occupation type",
                  isRequired: true,
                  value: provider.occupation,
                  items: const [
                    DropdownMenuItem(value: "Student", child: Text("Student")),
                    DropdownMenuItem(
                      value: "Working Professional",
                      child: Text("Working Professional"),
                    ),
                    DropdownMenuItem(value: "Other", child: Text("Other")),
                  ],
                  onChanged: (val) {
                    provider.selectOccupation(val ?? '');
                  },
                ),

                const SizedBox(height: 15),
                if (provider.isEmpty) ...[
                  _label(
                    provider.occupation == "Student"
                        ? "Studying"
                        : "Working as",
                  ),
                  AppTextField(
                    controller: provider.lanCtr,
                    hintText: provider.occupation == "Student"
                        ? "Bachelor of Engineering(CSE)"
                        : "Software Engineer",
                    filled: true,
                    fillColor: AppColors.background,
                  ),
                  const SizedBox(height: 15),
                ],

                _label("Languages You Know"),
                AppTextField(
                  controller: provider.lanCtr,
                  hintText: "English, Hindi & Other",
                  filled: true,
                  fillColor: AppColors.background,
                ),

                const SizedBox(height: 15),

                _label("Hobbies"),
                AppTextField(
                  controller: provider.hobbCtr,
                  hintText: "Reading, Music & Paintings",
                  filled: true,
                  fillColor: AppColors.background,
                ),

                const SizedBox(height: 15),

                // Loooking for shift by
                if (!widget.isShare) ...[
                  _label("Looking to shift by? *"),
                  TextField(
                    controller: provider.shiftDate,
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.calendar_month),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(), // 🚫 disables all past dates
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        provider.shiftDate.text =
                            "${picked.day}/${picked.month}/${picked.year}";
                      }
                    },
                  ),
                ],

                SizedBox(height: 20),
                AppButton(
                  text: "Save & Next",
                  onTap: () {
                    if (widget.isShare) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RoomDetailsPage(
                            needFor: widget.needRoom,
                            isSharing: widget.isShare,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddressDetailsPage(
                            path: "CO-LIVING",
                            isSharing: widget.isShare,
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 15),
                AppButton(
                  text: "Cancel",
                  onTap: () {},
                  backgroundColor: AppColors.red.shade100,
                  textColor: AppColors.black,
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  /// ---- Widgets ----

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _genderChip(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      border: Border.all(color: Colors.grey.shade400),
      borderRadius: BorderRadius.circular(10),
    );
  }
}

class DropdownTextField<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final bool isRequired;
  final Widget? prefixIcon;

  const DropdownTextField({
    super.key,

    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isRequired = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Dropdown Field
        DropdownButtonFormField<T>(
          initialValue: value,
          items: items,
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
}

Widget choiceChip(String label, String selected, Function(String) onTap) {
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
        color: isSelected ? AppColors.mainColors.withOpacity(.1) : Colors.white,
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
