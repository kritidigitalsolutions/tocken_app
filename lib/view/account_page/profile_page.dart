import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:token_app/main.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:token_app/utils/buttons.dart';
import 'package:token_app/utils/custom_dialogBox.dart';
import 'package:token_app/utils/helper/helper_method.dart';
import 'package:token_app/utils/text_style.dart';
import 'package:token_app/view/account_page/add_gst_number.dart';
import 'package:token_app/view/account_page/bookmarks_page.dart';
import 'package:token_app/view/account_page/direct_leads.dart';
import 'package:token_app/view/account_page/feedback_page.dart';
import 'package:token_app/view/account_page/help_support/help_And_Support_page.dart';
import 'package:token_app/view/account_page/offline_Notification.dart';
import 'package:token_app/viewModel/afterLogin/account_pages_provider/account_pages_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfilePagesProvider>();

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: AppColors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 50),
              Text('Account', style: textStyle18(FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.help_outline),
                onPressed: () async {
                  await makePhoneCall("6397892585");
                },
              ),
            ],
          ),
        ),

        /// Profile Card
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
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
                              radius: 30,
                              backgroundColor: Colors.red,
                              backgroundImage: provider.profileImage != null
                                  ? FileImage(provider.profileImage!)
                                  : null,
                              child: provider.profileImage == null
                                  ? const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  : null,
                            ),
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: Icon(
                                Icons.edit,
                                size: 20,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rajesh Kumar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.lock,
                                  size: 14,
                                  color: AppColors.grey,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  '+91 98765 43210',
                                  style: TextStyle(color: AppColors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      iconButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => AddGstNumber()),
                          );
                        },
                        icons: Icons.edit,
                        color: AppColors.grey,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// Menu Items
                _menuItem(Icons.chat_bubble_outline, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MyHomePage(screenIndex: 1),
                    ),
                  );
                }, 'My Leads'),
                _menuItem(
                  Icons.workspace_premium,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MyHomePage(screenIndex: 2),
                      ),
                    );
                  },
                  'Upgrade to Premium',
                  textColor: Colors.red,
                  bgColor: Colors.red.withOpacity(0.08),
                  iconColor: Colors.red,
                ),
                _menuItem(Icons.flash_on, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DirectLeads()),
                  );
                }, 'Request Direct Leads'),
                _menuItem(Icons.receipt_long, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddGstNumber()),
                  );
                }, 'Add GST Number'),
                _menuItem(Icons.bookmark_border, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => BookmarksPage()),
                  );
                }, 'Bookmarks'),
                _menuItem(Icons.notifications, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => OfflineNotification()),
                  );
                }, 'Offline Notifications'),
                _menuItem(Icons.music_off_outlined, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HelpAndSupportPage()),
                  );
                }, 'Help & Support'),
                _menuItem(Icons.chat_bubble_outline_outlined, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FeedbackPage()),
                  );
                }, 'Share Feedback'),

                AppButton(
                  text: "Logout",
                  onTap: () {
                    showCustomDialog(
                      context: context,
                      title: "Tocken",
                      confirmText: "Log out",
                      message: "Are you sure you want to log out?",
                    );
                  },
                  backgroundColor: AppColors.red.shade100,
                  textColor: AppColors.black,
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// --------------------
  /// MENU ITEM
  /// --------------------
  Widget _menuItem(
    IconData icon,
    VoidCallback onTap,
    String title, {
    Color iconColor = Colors.grey,
    Color textColor = Colors.black,
    Color bgColor = Colors.white,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade100,
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w500, color: textColor),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  /// --------------------
  /// IMAGE PICKER SHEET
  /// --------------------
  void _showImagePicker(BuildContext context) {
    final provider = context.read<ProfilePagesProvider>();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Profile Picture',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  provider.pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  provider.pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
