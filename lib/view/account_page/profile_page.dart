import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:token_app/main.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/custom_dialogBox.dart';
import 'package:token_app/utils/helper/helper_method.dart';
import 'package:token_app/utils/local_storage.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/account_page/account_privacy_page.dart';
import 'package:token_app/view/account_page/add_gst_number.dart';
import 'package:token_app/view/account_page/bookmarks_page.dart';
import 'package:token_app/view/account_page/direct_leads.dart';
import 'package:token_app/view/account_page/feedback_page.dart';
import 'package:token_app/view/account_page/help_support/help_And_Support_page.dart';
import 'package:token_app/view/account_page/my_listin_page.dart';
import 'package:token_app/view/account_page/offline_Notification.dart';
import 'package:token_app/view/account_page/phone_privacy.dart';
import 'package:token_app/view/beforeLogin/login_screen.dart';
import 'package:token_app/viewModel/afterLogin/account_pages_provider/account_pages_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  void _shareApp(BuildContext context) {
    const String appLink =
        "https://play.google.com/store/apps/details?id=com.tocken.app"; // replace with real link

    const String message =
        "🏠 Check out Tocken!\n\n"
        "Find PGs, Flats & Properties easily.\n\n"
        "Download now 👉 $appLink";

    SharePlus.instance.share(ShareParams(text: message));
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfilePagesProvider>();
    final provider1 = context.read<ProfileEditProvider>();
    provider1.getUserData();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Account", style: textStyle17(FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundColor: Colors.blue.shade50,
              child: IconButton(
                icon: const Icon(Icons.help_outline, color: AppColors.grey),
                onPressed: () async {
                  await makePhoneCall(provider1.phone);
                },
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// PROFILE CARD
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _showImagePicker(context),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.grey.shade300,
                          child: ClipOval(
                            child: provider.profileImage != null
                                ? Image.file(
                                    provider.profileImage!,
                                    width: 64,
                                    height: 64,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    provider1.profileImage,
                                    width: 64,
                                    height: 64,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.person,
                                        size: 30,
                                        color: Colors.grey,
                                      );
                                    },
                                  ),
                          ),
                        ),

                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: AppColors.mainColors,
                            child: const Icon(
                              Icons.edit,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Consumer<ProfileEditProvider>(
                    builder: (context, p, child) {
                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.lock, size: 14, color: Colors.grey),
                                SizedBox(width: 6),
                                Text(
                                  p.phone,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  iconButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AddGstNumber()),
                      );
                    },
                    icons: Icons.edit,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// MENU ITEMS
            _menuItem(Icons.list_alt, "My Listings", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MyListingPage()),
              );
            }),
            _menuItem(Icons.workspace_premium, "Upgrade To Premium", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MyHomePage(screenIndex: 2)),
              );
            }, highlight: true),
            _menuItem(Icons.flash_on, "Request Direct Leads", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DirectLeads()),
              );
            }),
            _menuItem(Icons.receipt_long, "Add GST Number", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddGstNumber()),
              );
            }),
            _menuItem(Icons.bookmark_border, "Bookmarks", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BookmarksPage()),
              );
            }),
            _menuItem(Icons.notifications_none, "Offline Notification", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => OfflineNotification()),
              );
            }),
            _menuItem(Icons.help_outline, "Help", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HelpAndSupportPage()),
              );
            }),
            _menuItem(Icons.chat_outlined, "Share Feedback", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FeedbackPage()),
              );
            }),
            // _menuItem(Icons.star_border, "Review App", () {}),
            _menuItem(Icons.group_add_outlined, "Refer Friends", () {
              _shareApp(context);
            }),
            _menuItem(Icons.headset_mic_outlined, "Talk to Experts", () async {
              await makePhoneCall("9999999999");
            }),
            _menuItem(Icons.phone_android, "Phone Number Privacy", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PhonePrivacy()),
              );
            }),
            _menuItem(Icons.lock_outline, "Account Privacy", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AccountPrivacyPage()),
              );
            }),

            const SizedBox(height: 16),

            _menuItem(Icons.logout, "Log out", () {
              showCustomDialog(
                context: context,
                title: "Tocken",
                confirmText: "Log out",
                message: "Are you sure you want to log out?",
                onConfirm: () async {
                  await LocalStorageService.clearData();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                    (route) => false,
                  );
                },
              );
            }, isLogout: true),

            const SizedBox(height: 30),
            const Text("Tocken", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// MENU TILE
  Widget _menuItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool highlight = false,
    bool isLogout = false,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: highlight ? Colors.red.shade50 : Colors.blue.shade50,
        child: Icon(
          icon,
          color: isLogout
              ? AppColors.mainColors
              : highlight
              ? AppColors.mainColors
              : AppColors.grey,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isLogout ? AppColors.mainColors : AppColors.black,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  /// IMAGE PICKER
  void _showImagePicker(BuildContext context) {
    final provider = context.read<ProfilePagesProvider>();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                provider.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                provider.pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }
}
