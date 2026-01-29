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

  bool get isSale =>
      "$type-$propertyType" == "Sell-Apartment" ||
      "$type-$propertyType" == "Sell-Builder Floor" ||
      "$type-$propertyType" == "Sell-Independent House" ||
      "$type-$propertyType" == "Sell-Villa" ||
      "$type-$propertyType" == "Sell-Plot/Land" ||
      "$type-$propertyType" == "Sell-Others";

  @override
  State<ApartmentDetailsPage> createState() => _ApartmentDetailsPageState();
}

class _ApartmentDetailsPageState extends State<ApartmentDetailsPage> {
  late final String saleType;

  @override
  void initState() {
    super.initState();
    saleType = "${widget.type}-${widget.propertyType}";
  }

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
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: widget.propertyType == "Plot/Land"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label("Expected Time of Possession *"),
                      _dropdown(
                        hint: "Select the expected time",
                        value: provider.expectedTime,
                        items: provider.expectedTimeList,
                        onChanged: (v) => provider.setExpectedTime,
                      ),
                      SizedBox(height: 15),
                      _label("Ownership *"),
                      _dropdown(
                        value: provider.owner,
                        hint: "Select the Ownership",
                        items: provider.ownerTypeList,
                        onChanged: (v) => provider.setOwner,
                      ),
                      SizedBox(height: 15),
                      _label("Plot Area *"),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: AppNumberField(
                              controller: provider
                                  .carpetAreaCtr, // ← probably typo → builtUpAreaCtr?
                              hintText: "",
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: _unitDropdown(
                              value: provider.builtMeasuType,
                              item: provider.measurmentList,
                              onChanged: (v) => provider.setBuildArea,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text("Dimensions", style: textStyle17(FontWeight.bold)),
                      SizedBox(height: 10),
                      _label("Lenght"),
                      AppNumberField(
                        controller: provider.cabinCtr,
                        hintText: "Lenght of the plot",
                        textWidget: provider.builtMeasuType,
                      ),

                      SizedBox(height: 15),

                      _label("Width"),
                      AppNumberField(
                        controller: provider.cabinCtr,
                        hintText: "Width of the plot",
                        textWidget: provider.builtMeasuType,
                      ),

                      SizedBox(height: 15),

                      _label("Width of facing road *"),
                      AppNumberField(
                        controller: provider.cabinCtr,
                        hintText: "Enter width of the road",
                        textWidget: provider.builtMeasuType,
                      ),
                      SizedBox(height: 15),

                      _label("No.of open sides *"),
                      Wrap(
                        spacing: 10,
                        children: List.generate(provider.noOfBathroom.length, (
                          index,
                        ) {
                          final value = provider.noOfBathroom[index];

                          return _stringNumberChip(
                            value, // label
                            // stored value
                            provider.openSide ?? '',
                            () {
                              provider.setOpenSide(value);
                            },
                          );
                        }),
                      ),

                      SizedBox(height: 15),

                      _label("No.of open sides *"),
                      Wrap(
                        spacing: 10,
                        children: provider.yesNoList
                            .map(
                              (y) => choiceChip(y, provider.yesOrNo ?? '', (_) {
                                provider.setYesOrNo(y);
                              }),
                            )
                            .toList(),
                      ),
                      if (provider.yesOrNo == "Yes") ...[
                        SizedBox(height: 10),
                        _label("What is the type of construction?*"),
                        Wrap(
                          spacing: 10,
                          children: provider.platLandConstructionList
                              .map(
                                (plot) => choiceChip(
                                  plot,
                                  provider.plotContr ?? '',
                                  (_) {
                                    provider.setPlotCon(plot);
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ],
                      const SizedBox(height: 15),
                      _label("Property Facing *"),
                      _dropdown(
                        hint: "Select the Property Facing",
                        value: provider.facing,
                        items: provider.facingList,
                        onChanged: (v) => provider.setFacing,
                      ),
                      _switchTile(
                        title: "With Boundary Wall",
                        subtitle: "",
                        value: provider.boundaryWall,
                        onChanged: (v) => provider.setBoundaryWall(v),
                      ),
                      _switchTile(
                        title: "Is it Corner Plot",
                        subtitle: "",
                        value: provider.cornerPlot,
                        onChanged: (v) => provider.setCornerPlot(v),
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
                              value: provider.isBrokerAllow,
                              onChanged: provider.toggleBroker,
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
                                isSell: widget.isSale,
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
                      // ─────────────────────────────────────────────
                      // Property Type (only for Others)
                      // ─────────────────────────────────────────────
                      if (widget.propertyType == "Others" ||
                          saleType == "Sell-Others") ...[
                        _label("Property Type *"),
                        AppTextField(
                          controller: provider.propertyTypeCtr,
                          hintText: "Enter the property type",
                        ),
                        const SizedBox(height: 15),
                      ],

                      // ─────────────────────────────────────────────
                      // Age / Construction Status
                      // ─────────────────────────────────────────────
                      if (!widget.isSale) ...[
                        _label("Age of the property *"),
                        _dropdown(
                          hint: "Select the age of the Property",
                          value: provider.propertyAge,
                          items: provider.ageOfProperty,
                          onChanged: (v) => provider.setAgeProperty,
                        ),
                      ] else ...[
                        _label("Construction Status *"),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: provider.constructionStatusList
                              .map(
                                (status) => choiceChip(
                                  status,
                                  provider.constructionStatus ?? '',
                                  (_) => provider.setConstructionStatus(status),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 15),

                        if (provider.constructionStatus == "Ready to Move") ...[
                          _label("Age of the property *"),
                          _dropdown(
                            hint: "Select the age of the Property",
                            value: provider.propertyAge,
                            items: provider.ageOfProperty,
                            onChanged: (v) => provider.setAgeProperty,
                          ),
                        ],

                        if (provider.constructionStatus ==
                            "Under Construction") ...[
                          _label("Expected Time of Possession *"),
                          _dropdown(
                            hint: "Select the expected time",
                            value: provider.expectedTime,
                            items: provider.expectedTimeList,
                            onChanged: (v) => provider.setExpectedTime,
                          ),
                        ],
                      ],

                      // ─────────────────────────────────────────────
                      // BHK Type
                      // ─────────────────────────────────────────────
                      if (widget.propertyType != "1RK/Studio House" &&
                          widget.propertyType != "Others" &&
                          saleType != "Sell-Others") ...[
                        const SizedBox(height: 15),
                        _label("BHK Type *"),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: provider.bhkList
                              .map(
                                (e) => choiceChip(
                                  e,
                                  provider.selectedBhk,
                                  (_) => provider.setBHKType(e),
                                ),
                              )
                              .toList(),
                        ),
                      ],

                      // ─────────────────────────────────────────────
                      // Bathrooms + Balconies (non-Others)
                      // ─────────────────────────────────────────────
                      if (widget.propertyType != "Others") ...[
                        const SizedBox(height: 15),
                        _label("No. of Bathrooms"),
                        _dropdown(
                          hint: "Select the No. of bathrooms",
                          value: provider.bathrooms,
                          items: provider
                              .noOfBalcony, // ← probably typo → should be noOfBathrooms?
                          onChanged: (v) => provider.setBathrooms,
                        ),
                        const SizedBox(height: 15),
                        _label("No. of Balconies"),
                        _dropdown(
                          hint: "Select the No. of balconies",
                          value: provider.balconies,
                          items: provider.noOfBalcony,
                          onChanged: (v) => provider.setBalcony,
                        ),
                      ],

                      const SizedBox(height: 15),

                      // ─────────────────────────────────────────────
                      // Additional Rooms
                      // ─────────────────────────────────────────────
                      _label("Any additional rooms?"),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: provider.roomList
                            .map(
                              (e) => boolChoiceChip(
                                e,
                                provider.isSelectedRoom(e),
                                () => provider.setAdditionalRoom(e),
                              ),
                            )
                            .toList(),
                      ),

                      const SizedBox(height: 15),

                      // ─────────────────────────────────────────────
                      // Furnish Type + Amenities (non Sale-Others)
                      // ─────────────────────────────────────────────
                      if (saleType != "Sell-Others") ...[
                        _label("Furnish Type *"),
                        _dropdown(
                          hint: "Select the Furnish Type",
                          value: provider.furnishType,
                          items: provider.furnishTypeList,
                          onChanged: (value) {
                            provider.setFurnishType(value ?? '');
                            if (provider.canOpenFurnishing) {
                              _showFurnishingBottomSheet(context);
                            }
                          },
                        ),

                        if (provider.furnishType == "Fully Furnished") ...[
                          const SizedBox(height: 8),
                          Text(
                            'Please select 6 amenities',
                            style: textStyle14(
                              FontWeight.w500,
                              color: AppColors.mainColors,
                            ),
                          ),
                          const SizedBox(height: 8),
                          AppButton(
                            text: "Select Amenities",
                            onTap: () => _showFurnishingBottomSheet(context),
                          ),
                        ],

                        if (provider.furnishType == "Semi Furnished") ...[
                          const SizedBox(height: 8),
                          Text(
                            'Please select 3 amenities',
                            style: textStyle14(
                              FontWeight.w500,
                              color: AppColors.mainColors,
                            ),
                          ),
                          const SizedBox(height: 8),
                          AppButton(
                            text: "Select Amenities",
                            onTap: () => _showFurnishingBottomSheet(context),
                          ),
                        ],

                        if (widget.propertyType != "Others") ...[
                          const SizedBox(height: 15),
                          _label("Facing"),
                          _dropdown(
                            hint: "Select the Facing",
                            value: provider.facing,
                            items: provider.facingList,
                            onChanged: (v) => provider.setFacing,
                          ),
                          const SizedBox(height: 15),
                          _label("Flooring Type"),
                          _dropdown(
                            hint: "Select the flooring type",
                            value: provider.flooring,
                            items: provider
                                .facingList, // ← probably typo → should be flooringList?
                            onChanged: (v) => provider.setFlooring,
                          ),
                        ],

                        const SizedBox(height: 15),

                        if (saleType == "Sell-Apartment" ||
                            saleType == "Sell-Builder Floor") ...[
                          _label("Ownership *"),
                          _dropdown(
                            value: provider.owner,
                            hint: "Select the Ownership",
                            items: provider.ownerTypeList,
                            onChanged: (v) => provider.setOwner,
                          ),
                          const SizedBox(height: 15),
                        ],
                      ],

                      // ─────────────────────────────────────────────
                      // Area Details Section
                      // ─────────────────────────────────────────────
                      _sectionTitle("Area Details"),

                      const SizedBox(height: 15),

                      Text("Built Up Area *"),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: AppNumberField(
                              controller: provider
                                  .carpetAreaCtr, // ← probably typo → builtUpAreaCtr?
                              hintText: "Enter Built up area",
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: _unitDropdown(
                              value: provider.builtMeasuType,
                              item: provider.measurmentList,
                              onChanged: (v) => provider.setBuildArea,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      Text("Carpet Area"),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: AppNumberField(
                              controller: provider.carpetAreaCtr,
                              hintText: "Enter carpet area",
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: _unitDropdown(
                              value: provider.carpetMeasuType,
                              item: provider.measurmentList,
                              onChanged: (v) => provider.setCarpetArea,
                            ),
                          ),
                        ],
                      ),

                      if (widget.propertyType != "Others" &&
                          saleType != "Sell-Others") ...[
                        const SizedBox(height: 15),
                        Text(
                          "Reserved Parking",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
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
                      ],

                      const SizedBox(height: 15),

                      // ─────────────────────────────────────────────
                      // Floors
                      // ─────────────────────────────────────────────
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Total Floors *"),
                                const SizedBox(height: 6),
                                AppNumberField(
                                  controller: provider.floorsController,
                                  hintText: "Enter total floors",
                                  maxLength: 2,
                                  min: 1,
                                  max: 50,
                                ),
                              ],
                            ),
                          ),
                          if (widget.propertyType != "Villa" &&
                              widget.propertyType != "Independent House" &&
                              saleType != "Sell-Independent House" &&
                              saleType != "Sell-Villa") ...[
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Your Floor *"),
                                  const SizedBox(height: 6),
                                  AppNumberField(
                                    controller: provider
                                        .floorsController, // ← probably typo → yourFloorController?
                                    hintText: "Enter your floor",
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

                      const SizedBox(height: 15),

                      // ─────────────────────────────────────────────
                      // Rent-specific fields
                      // ─────────────────────────────────────────────
                      if (!widget.isSale) ...[
                        _label("Preferred Tenant"),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: provider.prefeTenant
                              .map(
                                (e) => boolChoiceChip(
                                  e,
                                  provider.isSelectedTenant(e),
                                  () => provider.setTenant(e),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 15),
                        _label("Available Date *"),
                        TextField(
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
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null && mounted) {
                              provider.dateCtr.text =
                                  "${picked.day}/${picked.month}/${picked.year}";
                            }
                          },
                        ),
                      ],

                      const SizedBox(height: 15),

                      // ─────────────────────────────────────────────
                      // Broker Switch
                      // ─────────────────────────────────────────────
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
                              value: provider.isBrokerAllow,
                              onChanged: provider.toggleBroker,
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
                                isSell: widget.isSale,
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
                  ),
          );
        },
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Helper Methods
  // ─────────────────────────────────────────────

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _sectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 6),
        const Icon(Icons.help_outline, size: 18, color: Colors.grey),
      ],
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

  Widget _dropdown({
    required String hint,
    required List<String> items,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint),
      isExpanded: true,
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

  Widget _unitDropdown({
    required String value,
    required List<String> item,
    required ValueChanged<String?> onChanged,
  }) {
    return SizedBox(
      width: 100,
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        items: item
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  void _showFurnishingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const FurnishingBottomSheet(),
    );
  }
}
