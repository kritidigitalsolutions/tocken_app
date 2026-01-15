import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/textfield.dart';
import 'package:token_app/view/post_property_page/pricing_page.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/pg_provider.dart';

class PgDetailsPage extends StatelessWidget {
  const PgDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PgDetailsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("PG Details"),
        actions: [TextButton(onPressed: () {}, child: const Text("Help"))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label("PG Name *"),
            _textField(provider.pgNameController, "Enter your PG name"),

            _label("PG for *"),
            Wrap(
              spacing: 12,
              children: [
                SelectableChip(
                  label: "Male",
                  selected: provider.pgFor == "Male",
                  onTap: () => provider.selectPgFor("Male"),
                ),
                SelectableChip(
                  label: "Female",
                  selected: provider.pgFor == "Female",
                  onTap: () => provider.selectPgFor("Female"),
                ),
                SelectableChip(
                  label: "All",
                  selected: provider.pgFor == "All",
                  onTap: () => provider.selectPgFor("All"),
                ),
              ],
            ),

            _label("Best Suited for *"),
            Wrap(
              spacing: 12,
              children: [
                SelectableChip(
                  label: "Working",
                  selected: provider.bestSuitedFor == "Working",
                  onTap: () => provider.selectBestSuited("Working"),
                ),
                SelectableChip(
                  label: "Student",
                  selected: provider.bestSuitedFor == "Student",
                  onTap: () => provider.selectBestSuited("Student"),
                ),
                SelectableChip(
                  label: "Business",
                  selected: provider.bestSuitedFor == "Business",
                  onTap: () => provider.selectBestSuited("Business"),
                ),
              ],
            ),

            _label("Total Floors *"),
            AppTextField(
              controller: provider.floorsController,
              hintText: "Enter total floors",
              keyboardType: TextInputType.number,
            ),

            _label("Room Sharing Type *"),
            Wrap(
              spacing: 12,
              children: ["Private", "Twin", "Triple", "Quad"]
                  .map(
                    (e) => SelectableChip(
                      label: e,
                      selected: provider.roomSharing == e,
                      onTap: () => provider.selectRoomSharing(e),
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 24),
            _label("Capacity and Availability"),

            _label("Available no. of private rooms in PG*"),
            AppTextField(
              controller: provider.privateRoomsController,
              hintText: "Enter no. of private rooms",
              keyboardType: TextInputType.number,
            ),

            CheckboxListTile(
              value: provider.attachedBathroom,
              onChanged: (_) => provider.toggleBathroom(),
              title: const Text("Attached Bathroom"),
              controlAffinity: ListTileControlAffinity.leading,
            ),

            CheckboxListTile(
              value: provider.attachedBalcony,
              onChanged: (_) => provider.toggleBalcony(),
              title: const Text("Attached Balcony"),
              controlAffinity: ListTileControlAffinity.leading,
            ),

            _label("Furnish Type *"),
            _dropdown(provider.furnishType, [
              "Fully Furnished",
              "Semi Furnished",
              "Unfurnished",
            ], provider.setFurnishType),

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
            _dropdown(provider.propertyManagedBy, [
              "Owner",
              "Agent",
              "Company",
            ], provider.setPropertyManager),

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

            TextField(
              controller: provider.dataCtr,
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
                  provider.dataCtr.text =
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
                  MaterialPageRoute(
                    builder: (_) => PricingPage(propertyType: "PG"),
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
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 8),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
  );

  Widget _textField(
    TextEditingController c,
    String h, {
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextField(
      controller: c,
      keyboardType: keyboard,
      decoration: InputDecoration(
        hintText: h,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
            color: selected ? Colors.blue : Colors.grey.shade300,
            width: 1.5,
          ),
          color: selected ? Colors.blue.shade50 : Colors.white,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.blue : Colors.black,
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
