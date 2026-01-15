import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/view/post_property_page/address_details_page.dart';
import 'package:token_app/view/post_property_page/amenities_page.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/post_propert_providers.dart';

class RoomDetailsPage extends StatelessWidget {
  const RoomDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RoomDetailsProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Room Details"),
          centerTitle: true,
          actions: [TextButton(onPressed: () {}, child: const Text("Help"))],
        ),
        body: Consumer<RoomDetailsProvider>(
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
                        _dateField(context, p),

                        const SizedBox(height: 20),
                        _label("BHK *"),
                        Wrap(
                          spacing: 8,
                          children: p.bhkOptions.map((e) {
                            final selected = p.bhk == e;
                            return ChoiceChip(
                              label: Text(e),
                              selected: selected,
                              onSelected: (_) => p.setBhk(e),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 20),
                        _label("Furnish Type *"),
                        DropdownButtonFormField<String>(
                          initialValue: p.furnishType,
                          hint: const Text("Select the Furnish Type"),
                          items: p.furnishTypes
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                          onChanged: (v) {
                            p.setFurnish(v ?? '');
                          },
                          decoration: _inputDecoration(),
                        ),

                        const SizedBox(height: 20),
                        _label("Room details"),
                        Wrap(
                          spacing: 8,
                          children: p.roomDetailOptions.map((e) {
                            return ChoiceChip(
                              label: Text(e),
                              selected: p.roomDetails.contains(e),
                              onSelected: (_) => p.toggleRoomDetail(e),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: _textField(
                                label: "Total Floors *",
                                controller: p.totalFloorsCtrl,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _textField(
                                label: "Your Floor *",
                                controller: p.yourFloorCtrl,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Colors.grey),
                          ),
                          title: const Text("Amenities"),
                          subtitle: const Text("Please choose your Amenities"),
                          trailing: const Icon(Icons.add_circle_outline),
                          onTap: () {
                            openAmenitiesBottomSheet(
                              context,
                              "Select the Amenities",
                              amenitiesList,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                /// ACTION BUTTONS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: AppButton(
                    text: "Save & Next",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddressDetailsPage(path: "CO-LIVING"),
                        ),
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
            );
          },
        ),
      ),
    );
  }

  // ---------------- Widgets ----------------

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
  );

  Widget _dateField(BuildContext context, RoomDetailsProvider p) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
          initialDate: DateTime.now(),
        );
        if (date != null) p.setDate(date);
      },
      child: InputDecorator(
        decoration: _inputDecoration(suffix: const Icon(Icons.calendar_today)),
        child: Text(
          p.availableFrom == null
              ? "Select date"
              : "${p.availableFrom!.day}/${p.availableFrom!.month}/${p.availableFrom!.year}",
        ),
      ),
    );
  }

  Widget _textField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: _inputDecoration(),
        ),
      ],
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
