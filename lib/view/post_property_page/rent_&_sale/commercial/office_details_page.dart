import 'package:flutter/material.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/post_property_page/rent_&_sale/commercial/office_layout_page.dart';

class OfficeSpaceDetailsPage extends StatefulWidget {
  final String type;
  final String propertyClass;
  final String propertyType;
  const OfficeSpaceDetailsPage({
    super.key,
    required this.type,
    required this.propertyClass,
    required this.propertyType,
  });

  @override
  State<OfficeSpaceDetailsPage> createState() => _OfficeSpaceDetailsPageState();
}

class _OfficeSpaceDetailsPageState extends State<OfficeSpaceDetailsPage> {
  String constructionStatus = "Ready to Move";
  String propertyCondition = "Ready to Use";

  String? propertyAge;
  String? locationHub;
  String? zoneType;
  String? facing;
  String? flooring;
  String? owner;

  final List<String> flooringTypeList = [
    "Vitrified Tiles",
    "Marble",
    "Granite",
    "Wooden",
    "Laminated",
    "Ceramic Tiles",
    "Mosaic",
    "Italian Marble",
    "Cement",
    "Stone",
    "Other",
  ];
  final List<String> selectedFire = [];
  final List<String> fire = [
    "Fire Extinguisher",
    "Fire Sensors",
    "Sprinkles",
    "Firehose",
  ];
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
            Text(
              "${widget.propertyType} Details",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              "${widget.type} > ${widget.propertyClass} > ${widget.propertyType}",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Construction Status *"),
            _chipRow(
              ["Ready to Move", "Under Construction"],
              constructionStatus,
              (v) => setState(() => constructionStatus = v),
            ),

            _title("Age of the property *"),
            _dropdown(
              value: propertyAge,
              hint: "Age of the property",
              items: [
                "Less than 1 year",
                "1 - 5 years",
                "5 - 10 years",
                "10+ years",
              ],
              onChanged: (v) => setState(() => propertyAge = v),
            ),

            _title("Location Hub"),
            _dropdown(
              value: locationHub,
              hint: "Select the location hub",
              items: [
                "IT Park",
                "Business Park",
                "Commercial Complex",
                "Industrial Area",
              ],
              onChanged: (v) => setState(() => locationHub = v),
            ),

            _title("Zone Type *"),
            _dropdown(
              value: zoneType,
              hint: "Select the zone type",
              items: ["Commercial", "Industrial", "Residential", "SEZ"],
              onChanged: (v) => setState(() => zoneType = v),
            ),

            _title("Property Condition *"),
            _chipRow(
              ["Ready to Use", "Bare Shell"],
              propertyCondition,
              (v) => setState(() => propertyCondition = v),
            ),

            _title("Facing"),
            _dropdown(
              value: facing,
              hint: "Select the Facing",
              items: [
                "North",
                "South",
                "East",
                "West",
                "North-East",
                "North-West",
                "South-East",
                "South-West",
              ],
              onChanged: (v) => setState(() => facing = v),
            ),

            /// Flooring Type
            _title("Flooring Type"),
            _dropdown(
              hint: "Select the flooring type",
              value: flooring,
              items: flooringTypeList,
              onChanged: (v) => setState(() => flooring = v),
            ),

            _title("Ownership *"),
            _dropdown(
              value: owner,
              hint: "Select the Ownership",
              items: [
                "Freehold",
                "Power of attorney",
                "Lease Holder",
                "Cooperative Society",
              ],
              onChanged: (v) => setState(() => owner = v),
            ),
            const SizedBox(height: 20),
            apartmentAreaBody(),

            _title("Fire Safety Measures"),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              children: fire.map((e) => _tenantChip(e)).toList(),
            ),

            const SizedBox(height: 24),
            CheckboxListTile(
              value: false,
              onChanged: (v) {},
              title: Text("Occupancy Certificate"),
            ),
            CheckboxListTile(
              value: false,
              onChanged: (v) {},
              title: Text("Is your Office NOC certified?"),
            ),
            const SizedBox(height: 24),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        "Allow brokers to reach out",
                        style: textStyle14(FontWeight.bold),
                      ),
                      Icon(Icons.help_outline),
                    ],
                  ),
                  Spacer(),
                  Switch(value: true, onChanged: (v) {}),
                ],
              ),
            ),

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

  Widget _tenantChip(String value) {
    final bool selected = selectedFire.contains(value);
    return ChoiceChip(
      label: Text(value),
      selected: selected,
      onSelected: (_) {
        setState(() {
          selected ? selectedFire.remove(value) : selectedFire.add(value);
        });
      },
      selectedColor: Colors.blue.shade100,
    );
  }

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _dropdown({
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? value,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      hint: Text(hint),
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
    );
  }

  Widget _chipRow(
    List<String> options,
    String selected,
    ValueChanged<String> onTap,
  ) {
    return Wrap(
      spacing: 12,
      children: options.map((e) {
        final isSelected = e == selected;
        return ChoiceChip(
          label: Text(e),
          selected: isSelected,
          onSelected: (_) => onTap(e),
          selectedColor: Colors.blue.shade50,
          shape: StadiumBorder(
            side: BorderSide(
              color: isSelected ? Colors.blue : Colors.grey.shade400,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget apartmentAreaBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 Page Path (Previous Page)

        /// 🔹 Area Details Title
        Row(
          children: [
            Text(
              "Area Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 6),
            Icon(Icons.help_outline, size: 18, color: Colors.grey),
          ],
        ),

        const SizedBox(height: 20),

        /// 🔹 Built Up Area
        Text("Built Up Area *"),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter Built up area",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(flex: 1, child: _unitDropdown()),
          ],
        ),

        const SizedBox(height: 16),

        /// 🔹 Carpet Area
        Text("Carpet Area"),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter carpet area",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(flex: 1, child: _unitDropdown()),
          ],
        ),

        const SizedBox(height: 24),

        /// 🔹 Reserved Parking
        Text("Reserved Parking", style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),

        _parkingCounter(title: "Covered Parking"),
        const SizedBox(height: 12),
        _parkingCounter(title: "Open Parking"),

        const SizedBox(height: 24),

        /// 🔹 Floors
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Floors *"),
                  const SizedBox(height: 6),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter total floors",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your Floor *"),
                  const SizedBox(height: 6),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter your floor",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _unitDropdown() {
    return SizedBox(
      width: 90,
      child: DropdownButtonFormField<String>(
        initialValue: "Sq ft",
        items: [
          "Sq ft",
          "Sq m",
          "Sq yd",
          "Sq guz",
        ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (_) {},
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _parkingCounter({required String title}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Row(
            children: [
              _circleButton(Icons.remove),
              const SizedBox(width: 12),
              Text("00", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(width: 12),
              _circleButton(Icons.add),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18),
    );
  }
}
