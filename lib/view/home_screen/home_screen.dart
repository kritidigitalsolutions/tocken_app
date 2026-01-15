import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/utils/textfield.dart';
import 'package:token_app/view/home_screen/filter/filter_page.dart';
import 'package:token_app/view/home_screen/location_screen.dart';
import 'package:token_app/view/home_screen/notification_screen.dart';
import 'package:token_app/view/home_screen/property_list_page.dart';
import 'package:token_app/view/home_screen/property_review_page.dart';
import 'package:token_app/view/post_property_page/type_property_page.dart';
import 'package:token_app/viewModel/afterLogin/home_screen_controller.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/post_propert_providers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchCtr = TextEditingController();

  final FocusNode focusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 6,
                color: AppColors.grey.shade300,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _topBar(context),
              const SizedBox(height: 16),
              _searchBar(context, searchCtr, focusNode),
              const SizedBox(height: 16),
              Consumer<HomeScreenController>(
                builder: (context, controller, child) {
                  return _categoryTabs(controller, context);
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _premiumCard(),
                const SizedBox(height: 20),
                Consumer<HomeScreenController>(
                  builder: (context, controller, child) {
                    return _bhkChips(controller, context);
                  },
                ),
                const SizedBox(height: 24),
                _projectHeader("Project Section"),
                const SizedBox(height: 12),
                _projectList(context),
                const SizedBox(height: 12),
                _projectHeader("Recently Added"),
                const SizedBox(height: 12),
                _recentlyAddedCard(context),

                _projectHeader("Most Liked Properties"),
                const SizedBox(height: 12),
                _mostLikedProCard(context),
                const SizedBox(height: 12),
                _projectHeader("Developer Section"),

                _developerSection(),
                const SizedBox(height: 12),
                // _projectHeader("Broker Section"),
                // const SizedBox(height: 12),
                // _brokenSection(),
                // const SizedBox(height: 12),
                _projectHeader("Most Viewed"),
                _mostLikedProCard(context),
                const SizedBox(height: 12),
                _projectHeader("Popular Cities"),
                const SizedBox(height: 12),
                _mostViewed(context),
                const SizedBox(height: 12),
                _projectHeader("All Properties"),
                const SizedBox(height: 12),
                _recentlyAddedCard(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 🔴 Top Bar
  Widget _topBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LocationScreen()),
            );
          },
          child: Row(
            children: [
              Icon(Icons.location_on, color: AppColors.mainColors),
              SizedBox(width: 4),
              Text("Mumbai", style: textStyle16(FontWeight.w600)),
              SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, color: AppColors.black),
            ],
          ),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.mainColors,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: AppColors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              builder: (context) {
                return ChangeNotifierProvider.value(
                  value: context.read<TypePropertyProvider>(),
                  child: const TypePropertySheet(), // Bottom sheet widget
                );
              },
            );
          },
          icon: const Icon(Icons.add, color: AppColors.white),
          label: Text(
            "Post Property",
            style: textStyle15(FontWeight.bold, color: AppColors.white),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => NotificationScreen()),
            );
          },
          icon: Icon(Icons.notifications),
        ),
      ],
    );
  }

  Widget _searchBar(BuildContext context, controller, FocusNode focusNode) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FilterPage()),
              );
            },
            child: AbsorbPointer(
              child: AppTextField(
                controller: controller,
                focusNode: focusNode,

                hintText: "Search your house...",
                borderColor: AppColors.background,
                fillColor: AppColors.background,
                filled: true,

                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => FilterPage()),
            );
          },
          child: Container(
            height: 50,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.mainColors,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                Icons.filter_alt_outlined,
                color: AppColors.white,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 🏷 Rent / Buy / PG / Plot
  Widget _categoryTabs(HomeScreenController c, BuildContext context) {
    final tabs = ["Rent", "Buy", "PG", "Plot", "Commercial", "Projects"];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.map((e) {
          final isSelected = c.categoryTitle == e;
          print("build 2");
          return GestureDetector(
            onTap: () {
              c.toggleCategory(e);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PropertyListPage()),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.mainColors : AppColors.background,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      _categoryIcon(e),
                      color: isSelected ? AppColors.white : AppColors.grey,
                    ),
                    SizedBox(width: 2),
                    Text(
                      e,
                      style: textStyle15(
                        FontWeight.w600,
                        color: isSelected ? AppColors.white : AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ⭐ Premium Membership Card
  Widget _premiumCard() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSR1kD178WLfss3cXHB0HqZWVLKe8gvofbzdhJoQlrVF6lGIzNk",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.black.withOpacity(0.45),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Get Premium Membership",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "Unlock exclusive deals & offers",
              style: TextStyle(color: AppColors.white70),
            ),
          ],
        ),
      ),
    );
  }

  // 🛏 BHK Buttons
  Widget _bhkChips(HomeScreenController c, BuildContext context) {
    final items = ["1 BHK", "2 BHK", "3 BHK", "4 BHK", "5 +BHK"];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items.map((e) {
          final isSelected = c.bhkTitle == e;
          print("build 3");
          return GestureDetector(
            onTap: () {
              c.toggleBHK(e);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PropertyListPage()),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isSelected
                      ? AppColors.mainColors
                      : AppColors.background,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.grid_view_outlined, color: AppColors.mainColors),
                  SizedBox(width: 4),
                  Text(e, style: textStyle15(FontWeight.w600)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // 🏗 Project Header
  Widget _projectHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PropertyListPage()),
            );
          },
          child: Text("See All", style: TextStyle(color: AppColors.mainColors)),
        ),
      ],
    );
  }

  // 🏢 Project List
  Widget _projectList(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PropertyReviewPage()),
              );
            },
            child: _projectCard(
              title: "Skyline Heights",
              location: "Andheri West",
              image:
                  "https://i0.wp.com/riddhirealtors.com/wp-content/uploads/2022/02/architecture.jpg?fit=1900,1425&ssl=1",
              tag: "Upcoming",
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PropertyReviewPage()),
              );
            },
            child: _projectCard(
              title: "Palm Residency",
              location: "Bandra East",
              image:
                  "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSjde-MLv29X0KU-ShJ35hHoKqJIdfaZyvLNvyzQq07W-SZoB3_",
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PropertyReviewPage()),
              );
            },
            child: _projectCard(
              title: "Skyline Heights",
              location: "Andheri West",
              image:
                  "https://i0.wp.com/riddhirealtors.com/wp-content/uploads/2022/02/architecture.jpg?fit=1900,1425&ssl=1",
              tag: "Upcoming",
            ),
          ),
        ],
      ),
    );
  }

  Widget _projectCard({
    required String title,
    required String location,
    required String image,
    String? tag,
  }) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (tag != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(color: AppColors.white, fontSize: 12),
                ),
              ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              location,
              style: const TextStyle(color: AppColors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // Recent card added
  Widget _recentlyAddedCard(BuildContext context) {
    return Column(
      children: List.generate(4, (index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PropertyReviewPage()),
            );
          },
          child: Container(
            width: double.infinity,
            height: 150,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: AppColors.white70,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withAlpha(
                    25,
                  ), // slightly stronger for visibility
                  blurRadius: 6, // soft shadow
                  spreadRadius: 2,
                  offset: Offset(4, 0),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(10),
                    ),
                    child: SizedBox.expand(
                      // 👈 IMPORTANT
                      child: Image.network(
                        'https://images.unsplash.com/photo-1675279200694-8529c73b1fd0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=300',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.grey,
                            child: const Center(
                              child: Icon(Icons.error_outline),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('1BHK'),
                            Icon(Icons.favorite_border_outlined),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Modern 1bHK",
                          style: textStyle15(FontWeight.w500),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            Text('Location'),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          "20000 Lakhs",
                          style: textStyle16(
                            FontWeight.w500,
                            color: AppColors.mainColors,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // most Liked properties
  Widget _mostLikedProCard(BuildContext context) {
    return SizedBox(
      child: GridView.builder(
        padding: EdgeInsets.only(top: 0),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 4,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PropertyReviewPage()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withAlpha(
                      25,
                    ), // slightly stronger for visibility
                    blurRadius: 6, // soft shadow
                    spreadRadius: 2,
                    offset: Offset(4, 0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.vertical(
                        top: Radius.circular(10),
                      ),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=300',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(color: AppColors.grey),
                            child: Center(child: Icon(Icons.error_outline)),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1.2 L',
                          style: textStyle15(
                            FontWeight.w500,
                            color: AppColors.mainColors,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Luxury Home',
                          style: textStyle15(
                            FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            Text('Location'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Developer section
  Widget _developerSection() {
    return ListView.builder(
      shrinkWrap: true, // very important
      physics: NeverScrollableScrollPhysics(), // disable inner scrolling
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
          ),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.grey,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://images.unsplash.com/photo-1760138270903-d95903188730?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=200',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Icon(Icons.error_outline));
                  },
                ),
              ),
            ),
            title: Text("New Group", style: textStyle16(FontWeight.bold)),
            subtitle: Text(
              '24 Project',
              style: textStyle15(FontWeight.w500, color: AppColors.grey),
            ),
            // trailing: OutlineAppButton(
            //   text: 'View',
            //   onTap: () {},
            //   borderColor: AppColors.red,
            // ),
          ),
        );
      },
    );
  }

  // Widget _brokenSection() {
  //   return Column(
  //     children: List.generate(2, (index) {
  //       return Container(
  //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
  //         child: Column(
  //           children: [
  //             ListTile(
  //               leading: ClipOval(
  //                 child: Image.network(
  //                   'https://images.unsplash.com/photo-1560250097-0b93528c311a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=200',
  //                   width: 50,
  //                   height: 50,
  //                   fit: BoxFit.cover,
  //                   errorBuilder: (context, error, stackTrace) =>
  //                       Icon(Icons.image),
  //                 ),
  //               ),
  //               title: Text('Amit Kumar', style: textStyle16(FontWeight.bold)),
  //               subtitle: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Row(
  //                     children: [
  //                       Icon(Icons.location_on_outlined),
  //                       Text('Location'),
  //                     ],
  //                   ),
  //                   Text("REFN No. 1234566777"),
  //                 ],
  //               ),
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Text('45'),
  //                     SizedBox(height: 5),
  //                     Text('Projects'),
  //                   ],
  //                 ),
  //                 Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Text('45'),
  //                     SizedBox(height: 5),
  //                     Text('Projects'),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //     }),
  //   );
  // }

  Widget _mostViewed(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(4, (index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PropertyListPage()),
              );
            },
            child: Container(
              width: 190,
              height: 120,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(
                    "https://images.fineartamerica.com/images/artworkimages/small/2/mumbai-chatrapati-shivaji-terminus-victoria-terminus-at-evening-rush-hour-mumbai-india-ben-pipe-photography.jpg",
                  ),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) => Icon(Icons.image),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Mumbai",
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "200+",
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  IconData _categoryIcon(String text) {
    switch (text) {
      case "Rent":
        return Icons.key;
      case "Buy":
        return Icons.home;
      case "PG":
        return Icons.bed;
      case "Plot":
        return Icons.location_on_outlined;
      default:
        return Icons.category;
    }
  }
}
