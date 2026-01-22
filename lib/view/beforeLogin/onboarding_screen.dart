import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token_app/main.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/view/beforeLogin/login_screen.dart';
import 'package:token_app/viewModel/beforeLogin/auth_provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     context.read<OnboardingProvider>().getOnBoarding();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();

    /// 🔹 LOADING
    if (provider.isLoading && provider.onboardingItems.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    /// 🔹 ERROR
    if (provider.errorMessage != null && provider.onboardingItems.isEmpty) {
      return Scaffold(body: Center(child: Text(provider.errorMessage!)));
    }

    final list = provider.onboardingItems;

    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 IMAGE SLIDER
          CarouselSlider(
            items: list.map((item) {
              return Image.network(
                item.image,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, __, ___) => Container(color: Colors.grey),
              );
            }).toList(),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              onPageChanged: (index, reason) {
                provider.updateIndex(index);
              },
            ),
          ),

          /// 🔹 TEXT
          Positioned(
            bottom: 140,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Text(
                  list[provider.currentIndex].title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  list[provider.currentIndex].subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          /// 🔹 DOTS
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                list.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: provider.currentIndex == index ? 12 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: provider.currentIndex == index
                        ? Colors.white
                        : Colors.white54,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),

          /// 🔹 TOP BAR
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/tocken.png', height: 60, width: 100),
                  TextAppButton(
                    text: "Skip login",
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => MyHomePage()),
                        (route) => false,
                      );
                    },
                    color: AppColors.black,
                  ),
                ],
              ),
            ),
          ),

          /// 🔹 GET STARTED
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: AppButton(
              text: "Get Started",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// final List<OnboardingItem> onboardingList = [
//   OnboardingItem(
//     image: 'assets/onboarding/one.jpg',
//     title: "Discover Nearby PG’s",
//     subtitle:
//         "Discover the PG’s all over India, that suit your lifestyle and budget!",
//   ),
//   OnboardingItem(
//     image: 'assets/onboarding/two.jpg',
//     title: "Affordable Living Spaces",
//     subtitle:
//         "Find affordable PGs with modern amenities in your preferred location.",
//   ),
//   OnboardingItem(
//     image: 'assets/onboarding/three.jpg',
//     title: "Safe & Comfortable Homes",
//     subtitle: "Verified PGs with safety, comfort, and convenience guaranteed.",
//   ),
// ];

// class OnboardingItem {
//   final String image;
//   final String title;
//   final String subtitle;

//   OnboardingItem({
//     required this.image,
//     required this.title,
//     required this.subtitle,
//   });
// }
