import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/App_string.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/utils/textfield.dart';
import 'package:token_app/view/post_property_page/pg_pages/pg_price.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/pg_provider.dart';

class PgDetailsPage extends StatelessWidget {
  const PgDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PgDetailsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("PG Details", style: textStyle17(FontWeight.w900)),
            Text(
              "PG",
              style: textStyle14(FontWeight.w400, color: AppColors.grey),
            ),
          ],
        ),
        actions: [TextButton(onPressed: () {}, child: const Text("Help"))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label("PG Name *"),
            AppTextField(
              controller: provider.pgNameController,
              hintText: "Enter your PG name",
              validator: (String? value) {
                // ← String? explicitly likh do
                if (value == null || value.trim().isEmpty) {
                  return "Please enter PG name";
                }
                // Valid hai → null return karo (no error message)
                return null;
              },
            ),

            _label("PG for *"),
            Wrap(
              spacing: 12,
              children: provider.pgForList
                  .map(
                    (e) => SelectableChip(
                      label: e,
                      selected: provider.pgFor == e,
                      onTap: () => provider.selectPgFor(e),
                    ),
                  )
                  .toList(),
            ),

            _label("Best Suited for *"),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: provider.bestSuitedList
                  .map(
                    (e) => SelectableChip(
                      label: e,
                      selected: provider.isSelected(e),
                      onTap: () => provider.toggleBestSuited(e),
                    ),
                  )
                  .toList(),
            ),

            _label("Total Floors *"),
            AppNumberField(
              controller: provider.totalFloorsController,
              hintText: "Enter total floors",
              maxLength: 2,
              min: 1,
              max: 50,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter Total floor";
                }
                // Valid hai → null return karo (no error message)
                return null;
              },
            ),

            _label("Room Sharing Type *"),
            Wrap(
              spacing: 12,
              children: provider.roomSharingList
                  .map(
                    (e) => SelectableChip(
                      label: e,
                      selected: provider.isRoomSharingSelected(e),
                      onTap: () => provider.toggleRoomSharing(e),
                    ),
                  )
                  .toList(),
            ),

            _label("Capacity and Availability"),

            /// 🔹 SHOW DATA ONLY FOR SELECTED ROOM TYPES
            Column(
              children: provider.roomSharing.map((type) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label("Available no. of $type rooms *"),
                    AppNumberField(
                      controller: provider.getRoomController(type),
                      hintText: "Enter no. of $type rooms",
                      min: 0,
                      max: 999,
                    ),

                    CheckboxListTile(
                      value: provider.getBathroom(type),
                      onChanged: (_) => provider.toggleBathroom(type),
                      title: const Text("Attached Bathroom"),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),

                    CheckboxListTile(
                      value: provider.getBalcony(type),
                      onChanged: (_) => provider.toggleBalcony(type),
                      title: const Text("Attached Balcony"),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ],
                );
              }).toList(),
            ),

            _label("Furnish Type *"),
            _dropdown(provider.furnishType, provider.furnishTypeList, (value) {
              provider.setFurnishType(value);

              if (provider.canOpenFurnishing) {
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
            if (provider.furnishType == "Fully Furnished")
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

            if (provider.furnishType == "Semi Furnished")
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
                          maxHeight: MediaQuery.of(context).size.height * 0.7,
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

            _label("Reserved Parking"),
            CounterField(
              label: "No. of Covered Parking",
              value: provider.coveredParking,
              onAdd: provider.incCovered,
              onRemove: provider.decCovered,
            ),
            const SizedBox(height: 12),
            CounterField(
              label: "No. of Open Parking",
              value: provider.openParking,
              onAdd: provider.incOpen,
              onRemove: provider.decOpen,
            ),

            _label("Property Managed By"),
            _dropdown(
              provider.propertyManagedBy,
              provider.propertyManagedByList,
              provider.setPropertyManager,
            ),

            _label("Manager Stays at PG"),
            Wrap(
              spacing: 12,
              children: [
                SelectableChip(
                  label: "Yes",
                  selected: provider.managerStay == "Yes",
                  onTap: () => provider.selectManagerStay("Yes"),
                ),
                SelectableChip(
                  label: "NO",
                  selected: provider.managerStay == "No",
                  onTap: () => provider.selectManagerStay("No"),
                ),
              ],
            ),

            // Available date
            _label("Available Date *"),

            TextFormField(
              controller: provider.dateCtr,
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
                  provider.dateCtr.text =
                      "${picked.day}/${picked.month}/${picked.year}";
                }
              },
            ),

            const SizedBox(height: 24),
            AppButton(
              text: "Save & Next",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PgPrice()),
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

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 8),
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
}

class SelectableChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const SelectableChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ? AppColors.mainColors : AppColors.grey.shade300,
            width: 1.5,
          ),
          color: selected ? AppColors.red.shade50 : AppColors.white,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.mainColors : AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class CounterField extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CounterField({
    super.key,
    required this.label,
    required this.value,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          IconButton(onPressed: onRemove, icon: const Icon(Icons.remove)),
          Text(value.toString().padLeft(2, '0')),
          IconButton(onPressed: onAdd, icon: const Icon(Icons.add)),
        ],
      ),
    );
  }
}

class FurnishingBottomSheet extends StatelessWidget {
  const FurnishingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PgDetailsProvider>();
    final media = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: media.viewInsets.bottom + 16,
      ),
      child: ConstrainedBox(
        // Limit the max height so it doesn't overflow
        constraints: BoxConstraints(maxHeight: media.size.height * 0.8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔹 DRAG HANDLE
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Add Furnishings",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              "Please select at least ${provider.minRequiredAmenities} amenities.",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // 🔹 Make this scrollable
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: AppString.amenityList.map((item) {
                    return _item(
                      context,
                      "No. of ${item['name']}",
                      provider.getAmenityCount(item['key']!),
                      item['key']!,
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),

            AppButton(
              text: "Done",
              onTap: provider.isAmenitiesValid
                  ? () => Navigator.pop(context)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(BuildContext context, String title, int value, String key) {
    final provider = context.read<PgDetailsProvider>();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(child: Text(title)),
          IconButton(
            onPressed: () => provider.dec(key),
            icon: const Icon(Icons.remove),
          ),
          Text(value.toString().padLeft(2, '0')),
          IconButton(
            onPressed: () => provider.inc(key),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
