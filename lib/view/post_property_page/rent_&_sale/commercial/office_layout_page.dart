import 'package:flutter/material.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/textfield.dart';

class OfficeLayoutPage extends StatefulWidget {
  const OfficeLayoutPage({super.key});

  @override
  State<OfficeLayoutPage> createState() => _OfficeLayoutPageState();
}

class _OfficeLayoutPageState extends State<OfficeLayoutPage> {
  final TextEditingController cabinCtrl = TextEditingController();
  final TextEditingController meetingCtrl = TextEditingController();
  final TextEditingController seatsCtrl = TextEditingController();

  bool conferenceRoom = false;
  bool washrooms = false;
  bool furnished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Office Space"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton(onPressed: () {}, child: const Text("Help")),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Office Layout
            const Text(
              "Office Layout",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            const Text(
              "Select features and facilities included in the office",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            _title("Total Cabins *"),
            AppTextField(controller: cabinCtrl, hintText: "Enter total cabins"),

            _title("Total Meeting rooms *"),
            AppTextField(
              controller: meetingCtrl,
              hintText: "Enter Meeting rooms",
            ),

            _title("Total seats *"),
            AppTextField(controller: seatsCtrl, hintText: "Enter total seats"),

            const SizedBox(height: 30),

            /// Enable Features
            const Text(
              "Enable the available features",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            const Text(
              "Select the available facilities in your office space",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            _switchTile(
              title: "Conference Room",
              subtitle: "select no of conference room available",
              value: conferenceRoom,
              onChanged: (v) => setState(() => conferenceRoom = v),
            ),

            _divider(),

            _switchTile(
              title: "Washrooms",
              subtitle: "select no of Washroom available",
              value: washrooms,
              onChanged: (v) => setState(() => washrooms = v),
            ),

            _divider(),

            _switchTile(
              title: "Furnished",
              subtitle: "",
              value: furnished,
              onChanged: (v) => setState(() => furnished = v),
            ),

            const SizedBox(height: 30),

            /// Save & Next
            const SizedBox(height: 32),

            /// Save Button
            AppButton(
              text: "Save & Next",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => OfficeLayoutPage()),
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// ---------- Widgets ----------

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _switchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      subtitle,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.75, // 🔽 reduce switch size
            child: Switch(
              activeThumbColor: AppColors.white,
              activeTrackColor: AppColors.green,
              value: value,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Divider(thickness: 0.6);
  }
}
