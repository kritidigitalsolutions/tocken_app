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
import 'package:token_app/view/post_property_page/rent_&_sale/commercial/office_layout_page.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/pg_provider.dart';

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

  bool get isSale =>
      "$type-$propertyType" == "Sell-Office" ||
      "$type-$propertyType" == "Sell-Retail Shop" ||
      "$type-$propertyType" == "Sell-Showroom" ||
      "$type-$propertyType" == "Sell-Warehouse" ||
      "$type-$propertyType" == "Sell-Plot/land" ||
      "$type-$propertyType" == "Sell-Others";

  @override
  State<OfficeSpaceDetailsPage> createState() => _OfficeSpaceDetailsPageState();
}

class _OfficeSpaceDetailsPageState extends State<OfficeSpaceDetailsPage> {
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
      body: Consumer<PgDetailsProvider>(
        builder: (context, p, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: widget.propertyType == "Plot/Land"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title("Expected Time of Possession *"),
                      _dropdown(
                        hint: "Select the expected time",
                        value: p.expectedTime,
                        items: p.expectedTimeList,
                        onChanged: (v) => p.setExpectedTime,
                      ),
                      SizedBox(height: 15),
                      _title("Ownership *"),
                      _dropdown(
                        value: p.owner,
                        hint: "Select the Ownership",
                        items: p.ownerTypeList,
                        onChanged: (v) => p.setOwner,
                      ),
                      SizedBox(height: 15),
                      _title("Plot Area *"),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: AppNumberField(
                              controller: p
                                  .carpetAreaCtr, // ← probably typo → builtUpAreaCtr?
                              hintText: "",
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: _unitDropdown(
                              value: p.builtMeasuType,
                              item: p.measurmentList,
                              onChanged: (v) => p.setBuildArea,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text("Dimensions", style: textStyle17(FontWeight.bold)),
                      SizedBox(height: 10),
                      _title("Lenght"),
                      AppNumberField(
                        controller: p.cabinCtr,
                        hintText: "Lenght of the plot",
                        textWidget: p.builtMeasuType,
                      ),

                      SizedBox(height: 15),

                      _title("Width"),
                      AppNumberField(
                        controller: p.cabinCtr,
                        hintText: "Width of the plot",
                        textWidget: p.builtMeasuType,
                      ),

                      SizedBox(height: 15),

                      _title("Width of facing road *"),
                      AppNumberField(
                        controller: p.cabinCtr,
                        hintText: "Enter width of the road",
                        textWidget: p.builtMeasuType,
                      ),
                      SizedBox(height: 15),

                      _title("No.of open sides *"),
                      Wrap(
                        spacing: 10,
                        children: List.generate(p.noOfBathroom.length, (index) {
                          final value = p.noOfBathroom[index];

                          return _stringNumberChip(
                            value, // label
                            // stored value
                            p.openSide ?? '',
                            () {
                              p.setOpenSide(value);
                            },
                          );
                        }),
                      ),

                      SizedBox(height: 15),

                      _title("No.of open sides *"),
                      Wrap(
                        spacing: 10,
                        children: p.yesNoList
                            .map(
                              (y) => choiceChip(y, p.yesOrNo ?? '', (_) {
                                p.setYesOrNo(y);
                              }),
                            )
                            .toList(),
                      ),
                      if (p.yesOrNo == "Yes") ...[
                        SizedBox(height: 10),
                        _title("What is the type of construction?*"),
                        Wrap(
                          spacing: 10,
                          children: p.platLandConstructionList
                              .map(
                                (plot) =>
                                    choiceChip(plot, p.plotContr ?? '', (_) {
                                      p.setPlotCon(plot);
                                    }),
                              )
                              .toList(),
                        ),
                      ],
                      const SizedBox(height: 15),
                      _title("Property Facing *"),
                      _dropdown(
                        hint: "Select the Property Facing",
                        value: p.facing,
                        items: p.facingList,
                        onChanged: (v) => p.setFacing,
                      ),
                      _switchTile(
                        title: "With Boundary Wall",
                        subtitle: "",
                        value: p.boundaryWall,
                        onChanged: (v) => p.setBoundaryWall(v),
                      ),
                      _switchTile(
                        title: "Is it Corner Plot",
                        subtitle: "",
                        value: p.cornerPlot,
                        onChanged: (v) => p.setCornerPlot(v),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
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
                                const Icon(Icons.help_outline),
                              ],
                            ),
                            const Spacer(),
                            Switch(
                              value: p.isBrokerAllow,
                              onChanged: p.toggleBroker,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // ─────────────────────────────────────────────
                      // Action Buttons
                      // ─────────────────────────────────────────────
                      AppButton(
                        text: "Save & Next",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PricingPage(
                                propertyType: widget.propertyType,
                                type: widget.type,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      AppButton(
                        text: "Cancel",
                        onTap: () {},
                        textColor: AppColors.black,
                        backgroundColor: AppColors.red.shade100,
                      ),
                      const SizedBox(height: 20),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.propertyType == "Others") ...[
                        _title("Property Type *"),
                        AppTextField(
                          controller: p.propertyTypeCtr,
                          hintText: "Enter the property type",
                        ),
                      ],
                      _title("Construction Status *"),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: p.constructionStatusList
                            .map(
                              (status) => choiceChip(
                                status,
                                p.constructionStatus ?? '',
                                (_) {
                                  p.setConstructionStatus(status);
                                },
                              ),
                            )
                            .toList(),
                      ),

                      if (p.constructionStatus == "Ready to Move") ...[
                        _title("Age of the property *"),
                        _dropdown(
                          hint: "Select the age of the Property",
                          value: p.propertyAge,
                          items: p.ageOfProperty,
                          onChanged: (v) => p.setAgeProperty(v ?? ''),
                        ),
                      ],

                      if (widget.propertyType == "Retail Shop" ||
                          widget.propertyType == "Showroom" ||
                          widget.propertyType == "Warehouse") ...[
                        _title("No.of Whasrooms"),
                        _dropdown(
                          hint: "Select the No. of washrooms",
                          value: p.washroom,
                          items: p.washroomList,
                          onChanged: (v) => p.setWashroom(v ?? ''),
                        ),
                        if (widget.propertyType != "Warehouse") ...[
                          _title("Suitable For"),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              spacing: 10,
                              children: p.retailSuitableForList
                                  .map(
                                    (retail) => boolChoiceChip(
                                      retail,
                                      p.isSelectedSuitable(retail),
                                      () {
                                        p.setRetailSuitable(retail);
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ],

                      if (p.constructionStatus == "Under Construction") ...[
                        _title("Expected Time of Possession *"),
                        _dropdown(
                          hint: "Select the expected time",
                          value: p.expectedTime,
                          items: p.expectedTimeList,
                          onChanged: (v) => p.setExpectedTime(v ?? ''),
                        ),
                      ],

                      _title("Location Hub"),
                      _dropdown(
                        value: p.locationHub,
                        hint: "Select the location hub",
                        items: p.locationHubList,
                        onChanged: (v) => p.setLocationHub(v ?? ''),
                      ),

                      if (widget.propertyType != "Retail Shop" &&
                          widget.propertyType != "Showroom") ...[
                        _title("Zone Type *"),
                        _dropdown(
                          value: p.zoneType,
                          hint: "Select the zone type",
                          items: p.zoneList,
                          onChanged: (v) => p.setZone(v ?? ''),
                        ),
                        if (widget.propertyType != "Others") ...[
                          if (widget.propertyType != "Warehouse") ...[
                            _title("Property Condition *"),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: p.propertyConditionList
                                  .map(
                                    (status) => choiceChip(
                                      status,
                                      p.propertyCondition ?? '',
                                      (_) {
                                        p.setPropertyCondition(status);
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                            if (p.propertyCondition == "Ready to Use" ||
                                p.propertyCondition == "Bare Shell") ...[
                              _title("Available Date *"),

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
                                    firstDate:
                                        DateTime.now(), // 🚫 disables all past dates
                                    lastDate: DateTime(2100),
                                  );
                                  if (picked != null) {
                                    p.dateCtr.text =
                                        "${picked.day}/${picked.month}/${picked.year}";
                                  }
                                },
                              ),
                            ],

                            if (p.propertyCondition == "Bare Shell") ...[
                              _title("Construction Status of walls *"),
                              _dropdown(
                                hint: "Select Construction status of walls",
                                value: p.wall,
                                items: p.wallStatusList,
                                onChanged: (v) => p.setWall(v ?? ''),
                              ),
                            ],
                          ],
                        ],
                      ],

                      if (widget.propertyType != "Others") ...[
                        _title("Facing"),
                        _dropdown(
                          hint: "Select the Facing",
                          value: p.facing,
                          items: p.facingList,
                          onChanged: (v) => p.setFacing(v ?? ''),
                        ),

                        /// Flooring Type
                        _title("Flooring Type"),
                        _dropdown(
                          hint: "Select the flooring type",
                          value: p.flooring,
                          items: p.facingList,
                          onChanged: (v) => p.setFlooring(v ?? ''),
                        ),

                        _title("Ownership *"),
                        _dropdown(
                          value: p.owner,
                          hint: "Select the Ownership",
                          items: p.ownerTypeList,
                          onChanged: (v) => p.setOwner(v ?? ''),
                        ),
                      ],
                      const SizedBox(height: 20),

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
                              Icon(
                                Icons.help_outline,
                                size: 18,
                                color: Colors.grey,
                              ),
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
                          if (widget.propertyType != "Retail Shop" &&
                              widget.propertyType != "Showroom" &&
                              widget.propertyType != "Warehouse") ...[
                            if (widget.propertyType != "Others") ...[
                              if (widget.propertyType != "Office") ...[
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      widget.propertyType !=
                                          "Independent House") ...[
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                          ],
                        ],
                      ),
                      if (widget.propertyType != "Others") ...[
                        _title("Fire Safety Measures"),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: p.fire
                              .map(
                                (e) =>
                                    boolChoiceChip(e, p.isSelectedFireM(e), () {
                                      p.setFireMeas(e);
                                    }),
                              )
                              .toList(),
                        ),
                        if (widget.propertyType != "Retail Shop" &&
                            widget.propertyType != "Showroom" &&
                            widget.propertyType != "Warehouse") ...[
                          const SizedBox(height: 15),
                          CheckboxListTile(
                            value: p.isOccCerti,
                            onChanged: (v) {
                              p.toggleOccCerti(v ?? false);
                            },
                            title: Text("Occupancy Certificate"),
                          ),
                          CheckboxListTile(
                            value: p.isNOCCerti,
                            onChanged: (v) {
                              p.toggleNocCerti(v ?? false);
                            },
                            title: Text("Is your Office NOC certified?"),
                          ),
                        ],
                      ],
                      const SizedBox(height: 15),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
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
                          if (widget.propertyType == "Office") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => OfficeLayoutPage(
                                  type: widget.type,
                                  propertyType: widget.propertyType,
                                ),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PricingPage(
                                  propertyType: widget.propertyType,
                                  type: widget.type,
                                  isSell: widget.isSale,
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
      menuMaxHeight: 400,
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

  Widget _stringNumberChip(
    String label,
    String isSelected,
    VoidCallback onTap,
  ) {
    final bool selected = isSelected == label;

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
