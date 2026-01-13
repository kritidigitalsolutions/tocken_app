import 'package:flutter/material.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/post_property_page/rent_&_sale/residential/pricing_page.dart';

class ApartmentDetailsPage extends StatefulWidget {
  final String type;
  final String propertyClass;
  final String propertyType;
  const ApartmentDetailsPage({
    super.key,
    required this.type,
    required this.propertyClass,
    required this.propertyType,
  });

  @override
  State<ApartmentDetailsPage> createState() => _ApartmentDetailsPageState();
}

class _ApartmentDetailsPageState extends State<ApartmentDetailsPage> {
  final TextEditingController dateCtr = TextEditingController();
  String? propertyAge;
  String? bathrooms;
  String? balconies;
  String? furnishType;
  String? facing;
  String? flooring;

  String selectedBhk = "1BHK";
  final List<String> selectedRooms = [];

  final List<String> selectedTenant = [];

  final List<String> bhkList = ["1BHK", "2BHK", "3BHK", "4BHK", "5BHK"];
  final List<String> roomList = [
    "Pooja Room",
    "Home Gym",
    "Study Room",
    "Servant Room",
  ];

  final prefeTenant = ["Family", "Male", "Female", "Others"];

  final List<String> facingList = [
    "East",
    "West",
    "North",
    "South",
    "North-East",
    "North-West",
    "South-East",
    "South-West",
  ];

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

      /// BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Property Age
            _label("Age of the property *"),
            _dropdown(
              hint: "Select the age of the Property",
              value: propertyAge,
              items: const [
                "0-1 years",
                "1-5 years",
                "5-10 years",
                "10+ years",
              ],
              onChanged: (v) => setState(() => propertyAge = v),
            ),

            const SizedBox(height: 24),

            /// BHK Type
            _label("BHK Type *"),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              children: bhkList.map((e) => _bhkChip(e)).toList(),
            ),

            const SizedBox(height: 24),

            /// Bathrooms
            _label("No. of Bathrooms"),
            _dropdown(
              hint: "Select the No. of bathrooms",
              value: bathrooms,
              items: const ["1", "2", "3", "4+"],
              onChanged: (v) => setState(() => bathrooms = v),
            ),

            const SizedBox(height: 24),

            /// Balconies
            _label("No. of Balconies"),
            _dropdown(
              hint: "Select the No. of balconies",
              value: balconies,
              items: const ["0", "1", "2", "3+"],
              onChanged: (v) => setState(() => balconies = v),
            ),

            const SizedBox(height: 24),

            /// Additional Rooms
            _label("Any additional rooms?"),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              children: roomList.map((e) => _roomChip(e)).toList(),
            ),

            const SizedBox(height: 24),

            /// Furnish Type
            _label("Furnish Type *"),
            _dropdown(
              hint: "Select the Furnish Type",
              value: furnishType,
              items: const ["Semi Furnished", "Fully Furnished"],
              onChanged: (v) => setState(() => furnishType = v),
            ),

            const SizedBox(height: 24),

            /// Facing Type
            _label("Facing"),
            _dropdown(
              hint: "Select the Facing",
              value: facing,
              items: facingList,
              onChanged: (v) => setState(() => facing = v),
            ),

            const SizedBox(height: 24),

            /// Flooring Type
            _label("Flooring Type"),
            _dropdown(
              hint: "Select the flooring type",
              value: flooring,
              items: facingList,
              onChanged: (v) => setState(() => flooring = v),
            ),
            const SizedBox(height: 24),

            apartmentAreaBody(),
            const SizedBox(height: 24),

            _label("Preferred Tenant"),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              children: prefeTenant.map((e) => _tenantChip(e)).toList(),
            ),

            const SizedBox(height: 24),

            // Available date
            _label("Available Date *"),

            TextField(
              controller: dateCtr,
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
                  dateCtr.text = "${picked.day}/${picked.month}/${picked.year}";
                }
              },
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
                  MaterialPageRoute(builder: (_) => PricingPage()),
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

  /// ---------------- Widgets ----------------

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _dropdown({
    required String hint,
    required List<String> items,
    required String? value,
    required Function(String?) onChanged,
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
      ),
    );
  }

  Widget _bhkChip(String value) {
    final bool selected = selectedBhk == value;
    return ChoiceChip(
      label: Text(value),
      selected: selected,
      onSelected: (_) => setState(() => selectedBhk = value),
      selectedColor: Colors.blue.shade100,
    );
  }

  Widget _roomChip(String value) {
    final bool selected = selectedRooms.contains(value);
    return ChoiceChip(
      label: Text(value),
      selected: selected,
      onSelected: (_) {
        setState(() {
          selected ? selectedRooms.remove(value) : selectedRooms.add(value);
        });
      },
      selectedColor: Colors.blue.shade100,
    );
  }

  Widget _tenantChip(String value) {
    final bool selected = selectedTenant.contains(value);
    return ChoiceChip(
      label: Text(value),
      selected: selected,
      onSelected: (_) {
        setState(() {
          selected ? selectedTenant.remove(value) : selectedTenant.add(value);
        });
      },
      selectedColor: Colors.blue.shade100,
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
