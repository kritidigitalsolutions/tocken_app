import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/textfield.dart';
import 'package:token_app/view/post_property_page/co_living_pages/profile_details_page.dart';
import 'package:token_app/view/post_property_page/pricing_page.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/pg_provider.dart';

class OfficeLayoutPage extends StatefulWidget {
  final bool? isSell;
  const OfficeLayoutPage({super.key, this.isSell});

  @override
  State<OfficeLayoutPage> createState() => _OfficeLayoutPageState();
}

class _OfficeLayoutPageState extends State<OfficeLayoutPage> {
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
      body: Consumer<PgDetailsProvider>(
        builder: (context, p, child) {
          return SingleChildScrollView(
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
                AppNumberField(
                  controller: p.cabinCtr,
                  hintText: "Enter total cabins",
                ),

                _title("Total Meeting rooms *"),
                AppNumberField(
                  controller: p.meetingRoomCtr,
                  hintText: "Enter Meeting rooms",
                ),

                _title("Total seats *"),
                AppNumberField(
                  controller: p.seatsCtr,
                  hintText: "Enter total seats",
                ),

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
                  value: p.conferenceRoom,
                  onChanged: (v) => p.setConferenceRoom(v),
                ),
                if (p.conferenceRoom) ...[
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    children: List.generate(6, (index) {
                      final actualValue = (index + 1).toString();
                      final displayText = (index == 5) ? "6+" : actualValue;

                      return _stringNumberChip(
                        displayText, // label
                        actualValue, // stored value
                        p.leaseYear ?? '',
                        () {
                          p.setLeaseYear(actualValue);
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 8),
                ],

                _divider(),

                _switchTile(
                  title: "Washrooms",
                  subtitle: "select no of Washroom available",
                  value: p.washrooms,
                  onChanged: (v) => p.setWashrooms(v),
                ),
                if (p.washrooms) ...[
                  SizedBox(height: 8),
                  _title("Private Washroom"),
                  Wrap(
                    spacing: 10,
                    children: List.generate(6, (index) {
                      final actualValue = (index + 1).toString();
                      final displayText = (index == 5) ? "6+" : actualValue;

                      return _stringNumberChip(
                        displayText, // label
                        actualValue, // stored value
                        p.privateWashroom ?? '',
                        () {
                          p.setPrivateWashroomr(actualValue);
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 10),
                  _title("Public Washroom"),
                  Wrap(
                    spacing: 10,
                    children: List.generate(6, (index) {
                      final actualValue = (index + 1).toString();
                      final displayText = (index == 5) ? "6+" : actualValue;

                      return _stringNumberChip(
                        displayText, // label
                        actualValue, // stored value
                        p.pubWashroom ?? '',
                        () {
                          p.setPubWashroom(actualValue);
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 8),
                ],

                _divider(),

                _switchTile(
                  title: "Furnished",
                  subtitle: "",
                  value: p.furnished,
                  onChanged: (v) => p.setFurnished(v),
                ),

                _divider(),

                _switchTile(
                  title: "Reception Area",
                  subtitle: "",
                  value: p.receptionArea,
                  onChanged: (v) => p.setReceptionArea(v),
                ),

                _divider(),

                _switchTile(
                  title: "Pantry",
                  subtitle: "",
                  value: p.pantry,
                  onChanged: (v) => p.setPantry(v),
                ),
                if (p.pantry) ...[
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    children: p.pantryList
                        .map(
                          (type) =>
                              choiceChip(type, p.selectedPantry ?? '', (_) {
                                p.togglePantry(type);
                              }),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 8),
                  _title("Pantry Size"),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: AppNumberField(
                          controller: p.carpetAreaCtr,
                          hintText: "Enter the pantry size",
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: _unitDropdown(
                          value: p.builtMeasuType,
                          item: p.measurmentList,
                          onChanged: (v) {
                            p.setBuildArea(v ?? '');
                          },
                        ),
                      ),
                    ],
                  ),
                ],

                _divider(),

                _switchTile(
                  title: "Central AC",
                  subtitle: "",
                  value: p.centralAc,
                  onChanged: (v) => p.setCentralAc(v),
                ),

                _divider(),

                _switchTile(
                  title: "UPS",
                  subtitle: "",
                  value: p.ups,
                  onChanged: (v) => p.setUps(v),
                ),

                _divider(),

                _switchTile(
                  title: "Oxygen duct",
                  subtitle: "",
                  value: p.oxygenDuct,
                  onChanged: (v) => p.setOxygenDuct(v),
                ),

                SizedBox(height: 15),

                _title("No.of Passenger Lifts*"),
                Wrap(
                  spacing: 10,
                  children: List.generate(6, (index) {
                    final actualValue = (index + 1).toString();
                    final displayText = (index == 5) ? "6+" : actualValue;

                    return _stringNumberChip(
                      displayText, // label
                      actualValue, // stored value
                      p.pLifts ?? '',
                      () {
                        p.setPLift(actualValue);
                      },
                    );
                  }),
                ),

                _title("No.of Service Lifts*"),
                Wrap(
                  spacing: 10,
                  children: List.generate(6, (index) {
                    final actualValue = (index + 1).toString();
                    final displayText = (index == 5) ? "6+" : actualValue;

                    return _stringNumberChip(
                      displayText, // label
                      actualValue, // stored value
                      p.sLift ?? '',
                      () {
                        p.setSLift(actualValue);
                      },
                    );
                  }),
                ),
                SizedBox(height: 15),

                _title("Parking Option *"),
                Wrap(
                  spacing: 10,
                  children: p.parkingOption.map((option) {
                    return choiceChip(option, p.selectedParkingOption ?? '', (
                      _,
                    ) {
                      p.setParkingOption(option);
                    });
                  }).toList(),
                ),
                if (p.selectedParkingOption == "Available") ...[
                  const SizedBox(height: 12),
                  _title("Parking Type *"),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: p.parkingTypeList.map((type) {
                      final bool isSelected = p.selectedParkingTypes.contains(
                        type,
                      );

                      return choiceChip(type, isSelected ? type : '', (_) {
                        p.toggleParkingType(type);
                      });
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  AppTextField(
                    controller: p.parkingCtr,
                    hintText: "Enter No.of Parking",
                  ),
                ],

                const SizedBox(height: 32),

                /// Save Button
                AppButton(
                  text: "Save & Next",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PricingPage(propertyType: "COM"),
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
                SizedBox(height: 20),
              ],
            ),
          );
        },
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

  Widget _stringNumberChip(
    String label,
    String value,
    String isSelected,
    VoidCallback onTap,
  ) {
    final bool selected = isSelected == value;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? AppColors.mainColors : Colors.grey.shade300,
          ),
          color: selected ? AppColors.mainColors.withOpacity(.1) : Colors.white,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.mainColors : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  Widget _unitDropdown({
    required String value,
    required List<String> item,
    required Function(String?) onChanged,
  }) {
    return SizedBox(
      width: 90,
      child: DropdownButtonFormField<String>(
        initialValue: value,
        items: item
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _switchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
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
    );
  }

  Widget _divider() {
    return const Divider(thickness: 0.6);
  }
}
