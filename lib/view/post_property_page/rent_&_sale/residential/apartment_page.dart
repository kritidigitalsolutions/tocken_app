import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/utils/textfield.dart';
import 'package:token_app/view/post_property_page/co_living_pages/profile_details_page.dart';
import 'package:token_app/view/post_property_page/pg_pages/pg_details.dart';
import 'package:token_app/view/post_property_page/pg_pages/pg_price.dart';
import 'package:token_app/view/post_property_page/pricing_page.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/pg_provider.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/rent_sale_provider.dart';

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
      body: Consumer<PgDetailsProvider>(
        builder: (context, p, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Property type
                if (widget.propertyType == "Others") ...[
                  _label("Property Type *"),
                  AppTextField(
                    controller: p.propertyTypeCtr,
                    hintText: "Enter the property type",
                  ),
                  const SizedBox(height: 15),
                ],

                /// Property Age
                _label("Age of the property *"),
                _dropdown(
                  hint: "Select the age of the Property",
                  value: p.propertyAge,
                  items: p.ageOfProperty,
                  onChanged: (v) => p.setAgeProperty(v ?? ''),
                ),

                /// BHK Type
                if (widget.propertyType != "1RK/Studio House" &&
                    widget.propertyType != "Others") ...[
                  const SizedBox(height: 15),
                  _label("BHK Type *"),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: p.bhkList
                        .map(
                          (e) => choiceChip(e, p.selectedBhk, (_) {
                            p.setBHKType(e);
                          }),
                        )
                        .toList(),
                  ),
                ],

                if (widget.propertyType != "Others") ...[
                  const SizedBox(height: 15),

                  /// Bathrooms
                  _label("No. of Bathrooms"),
                  _dropdown(
                    hint: "Select the No. of bathrooms",
                    value: p.bathrooms,
                    items: p.noOfBalcony,
                    onChanged: (v) => p.setBathrooms(v ?? ''),
                  ),

                  const SizedBox(height: 15),

                  /// Balconies
                  _label("No. of Balconies"),
                  _dropdown(
                    hint: "Select the No. of balconies",
                    value: p.balconies,
                    items: p.noOfBalcony,
                    onChanged: (v) => p.setBalcony(v ?? ''),
                  ),
                ],

                const SizedBox(height: 15),

                /// Additional Rooms
                _label("Any additional rooms?"),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: p.roomList
                      .map(
                        (e) => boolChoiceChip(e, p.isSelectedRoom(e), () {
                          p.setAdditionalRoom(e);
                        }),
                      )
                      .toList(),
                ),

                const SizedBox(height: 15),

                /// Furnish Type
                _label("Furnish Type *"),
                _dropdown(
                  hint: "Select the Furnish Type",
                  value: p.furnishType,
                  items: p.furnishTypeList,
                  onChanged: (value) {
                    p.setFurnishType(value ?? '');

                    if (p.canOpenFurnishing) {
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
                  },
                ),
                if (p.furnishType == "Fully Furnished")
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

                if (p.furnishType == "Semi Furnished")
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
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.7,
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

                if (widget.propertyType != "Others") ...[
                  const SizedBox(height: 15),

                  /// Facing Type
                  _label("Facing"),
                  _dropdown(
                    hint: "Select the Facing",
                    value: p.facing,
                    items: p.facingList,
                    onChanged: (v) => p.setFacing(v ?? ''),
                  ),

                  const SizedBox(height: 15),

                  /// Flooring Type
                  _label("Flooring Type"),
                  _dropdown(
                    hint: "Select the flooring type",
                    value: p.flooring,
                    items: p.facingList,
                    onChanged: (v) => p.setFlooring(v ?? ''),
                  ),
                ],
                const SizedBox(height: 15),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🔹 Page Path (Previous Page)

                    /// 🔹 Area Details Title
                    Row(
                      children: [
                        Text(
                          "Area Details",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(Icons.help_outline, size: 18, color: Colors.grey),
                      ],
                    ),

                    const SizedBox(height: 15),

                    /// 🔹 Built Up Area
                    Text("Built Up Area *"),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: AppNumberField(
                            controller: p.carpetAreaCtr,
                            hintText: "Enter Built up area",
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

                    const SizedBox(height: 15),

                    /// 🔹 Carpet Area
                    Text("Carpet Area"),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: AppNumberField(
                            controller: p.carpetAreaCtr,
                            hintText: "Enter carpet area",
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 1,
                          child: _unitDropdown(
                            value: p.carpetMeasuType,
                            item: p.measurmentList,
                            onChanged: (v) {
                              p.setCarpetArea(v ?? '');
                            },
                          ),
                        ),
                      ],
                    ),

                    if (widget.propertyType != "Others") ...[
                      const SizedBox(height: 15),

                      /// 🔹 Reserved Parking
                      Text(
                        "Reserved Parking",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),

                      CounterField(
                        label: "No. of Covered Parking",
                        value: p.coveredParking,
                        onAdd: p.incCovered,
                        onRemove: p.decCovered,
                      ),
                      const SizedBox(height: 12),
                      CounterField(
                        label: "No. of Open Parking",
                        value: p.openParking,
                        onAdd: p.incOpen,
                        onRemove: p.decOpen,
                      ),
                    ],
                    const SizedBox(height: 15),

                    /// 🔹 Floors
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Total Floors *"),
                              const SizedBox(height: 6),
                              AppNumberField(
                                controller: p.floorsController,
                                hintText: "Enter total floors",
                                maxLength: 2,
                                min: 1,
                                max: 50,
                              ),
                            ],
                          ),
                        ),
                        if (widget.propertyType != "Villa" &&
                            widget.propertyType != "Independent House") ...[
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Your Floor *"),
                                const SizedBox(height: 6),
                                AppNumberField(
                                  controller: p.floorsController,
                                  hintText: "Enter your floors",
                                  maxLength: 2,
                                  min: 1,
                                  max: 50,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                _label("Preferred Tenant"),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: p.prefeTenant
                      .map(
                        (e) => boolChoiceChip(e, p.isSelectedTenant(e), () {
                          p.setTenant(e);
                        }),
                      )
                      .toList(),
                ),

                const SizedBox(height: 15),

                // Available date
                _label("Available Date *"),

                TextField(
                  controller: p.dateCtr,
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
                      p.dateCtr.text =
                          "${picked.day}/${picked.month}/${picked.year}";
                    }
                  },
                ),

                const SizedBox(height: 15),

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
                      Switch(
                        value: p.isBrokerAllow,
                        onChanged: (v) {
                          p.toggleBroker(v);
                        },
                      ),
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
          );
        },
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
}
