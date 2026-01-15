import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/viewModel/afterLogin/account_pages_provider/my_listing_provider.dart';

class MyListingPage extends StatefulWidget {
  const MyListingPage({super.key});

  @override
  State<MyListingPage> createState() => _MyListingPageState();
}

class _MyListingPageState extends State<MyListingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const mainTabs = [
    "All",
    "Residential",
    "Commercial",
    "PG",
    "Plot",
    "Co-living",
  ];

  static const subTabs = ["All", "To Rent", "To Lease", "To Sell"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: mainTabs.length, vsync: this);

    /// ✅ THIS IS THE KEY FIX
    _tabController.addListener(() {
      if (_tabController.indexIsChanging == false) {
        context.read<MyListingProvider>().changeMainTab(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyListingProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: Text("My Listing", style: textStyle17(FontWeight.bold)),
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_alt_outlined),
                onPressed: () => _showFilterSheet(context),
              ),
              IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () => _showSortSheet(context),
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              onTap: (i) {
                provider.changeMainTab(i);
                _tabController.animateTo(i);
              },
              tabs: mainTabs.map((e) => Tab(text: e)).toList(),
            ),
          ),

          /// ✅ SWIPE WORKS + PROVIDER UPDATED
          body: TabBarView(
            controller: _tabController,
            children: List.generate(
              mainTabs.length,
              (_) => _tabContent(provider),
            ),
          ),
        );
      },
    );
  }

  Widget _tabContent(MyListingProvider provider) {
    return Column(
      children: [
        const SizedBox(height: 12),

        /// ✅ SUB TAB NOW SHOWS ON SWIPE ALSO
        if (provider.mainTabIndex == 1 || provider.mainTabIndex == 2)
          SizedBox(
            height: 36,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: subTabs.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, index) {
                final isSelected = provider.subTabIndex == index;
                return ChoiceChip(
                  label: Text(subTabs[index]),
                  selected: isSelected,
                  onSelected: (_) => provider.changeSubTab(index),
                );
              },
            ),
          ),

        const SizedBox(height: 24),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [ListingCard()],
          ),
        ),
      ],
    );
  }
}

/// ================= FILTER =================
void _showFilterSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => Consumer<MyListingProvider>(
      builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Filter Properties",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              ...ListingStatus.values.map(
                (e) => CheckboxListTile(
                  value: provider.selectedStatus.contains(e),
                  onChanged: (_) => provider.toggleStatus(e),
                  title: Text(e.name.capitalize()),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Apply Filter"),
              ),
            ],
          ),
        );
      },
    ),
  );
}

/// ================= SORT =================
void _showSortSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => Consumer<MyListingProvider>(
      builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Sort Properties",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              ...SortType.values.map(
                (e) => RadioListTile<SortType>(
                  value: e,
                  groupValue: provider.sortType,

                  title: Text(e.name.capitalize()),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

/// ================= STRING EXT =================
extension Cap on String {
  String capitalize() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}

class ListingCard extends StatefulWidget {
  const ListingCard({super.key});

  @override
  State<ListingCard> createState() => _ListingCardState();
}

class _ListingCardState extends State<ListingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnim;

  final double targetProgress = 0.5; // 50%

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _progressAnim = Tween<double>(
      begin: 0,
      end: targetProgress,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TOP ROW
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _image(),
                const SizedBox(width: 12),
                Expanded(child: _details()),
              ],
            ),

            const SizedBox(height: 12),

            /// PROGRESS
            _progressSection(),
          ],
        ),
      ),
    );
  }

  Widget _image() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        'https://images.unsplash.com/photo-1502685104226-ee32379fefbe',
        width: 70,
        height: 70,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _details() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text(
              "Co-living",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Spacer(),
            Icon(Icons.check_circle, size: 14, color: Colors.green),
            SizedBox(width: 4),
            Text(
              "Active",
              style: TextStyle(
                fontSize: 12,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          "2 1K-1L / Month",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 2),
        const Text(
          "Need a Room/Flat\nAgra H O, Agra Sub-District",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        const Text(
          "Expires in 13 days",
          style: TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _progressSection() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xffFFF4F4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("Current visibility", style: TextStyle(fontSize: 12)),
              const Spacer(),
              AnimatedBuilder(
                animation: _progressAnim,
                builder: (_, __) {
                  return Text(
                    "${(_progressAnim.value * 100).toInt()}%",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 6),

          /// PROGRESS BAR
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: AnimatedBuilder(
              animation: _progressAnim,
              builder: (_, __) {
                return LinearProgressIndicator(
                  value: _progressAnim.value,
                  minHeight: 8,
                  backgroundColor: Colors.red.withOpacity(0.15),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                );
              },
            ),
          ),

          const SizedBox(height: 6),
          const Text(
            "Add the missing property details to reach more seekers and increase the listing score by +50% more",
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
