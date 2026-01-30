import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:token_app/resources/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:token_app/utils/bottom_navigationbar.dart';
import 'package:token_app/view/beforeLogin/splash_screen.dart';
import 'package:token_app/view/post_property_page/type_property_page.dart';
import 'package:token_app/viewModel/afterLogin/account_pages_provider/account_pages_provider.dart';
import 'package:token_app/viewModel/afterLogin/account_pages_provider/my_listing_provider.dart';
import 'package:token_app/viewModel/afterLogin/filter_pages_provider/filter_provider.dart';
import 'package:token_app/viewModel/afterLogin/home_screen_provider.dart';
import 'package:token_app/viewModel/afterLogin/leadScreenProvider/leads_screen_controller.dart';
import 'package:token_app/viewModel/afterLogin/location_provider.dart';
import 'package:token_app/viewModel/afterLogin/plans_provider/plan_provider.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/co_living_provider.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/pg_provider.dart';
import 'package:token_app/viewModel/afterLogin/post_property_provider/post_propert_providers.dart';
import 'package:token_app/viewModel/beforeLogin/auth_provider.dart';
import 'package:token_app/viewModel/policy_view_model/policy_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeScreenProvicer()),
        ChangeNotifierProvider(create: (_) => LeadsScreenController()),
        ChangeNotifierProvider(create: (_) => TypePropertyProvider()),
        ChangeNotifierProvider(create: (_) => PropertyDetailsProvider()),
        ChangeNotifierProvider(create: (_) => AddressDetailsProvider()),
        ChangeNotifierProvider(create: (_) => PlanDetailsProvider()),
        ChangeNotifierProvider(create: (_) => ProfilePagesProvider()),
        ChangeNotifierProvider(
          create: (_) => OnboardingProvider()..getOnBoarding(),
        ),
        ChangeNotifierProvider(create: (_) => PhoneNumberProvider()),
        ChangeNotifierProvider(create: (_) => OtpVerificationProvider()),
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
        ChangeNotifierProvider(create: (_) => DirectLeadsProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => FeedbackProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
        ChangeNotifierProvider(create: (_) => PgDetailsProvider()),
        ChangeNotifierProvider(create: (_) => DeleteAccountProvider()),
        ChangeNotifierProvider(create: (_) => MyListingProvider()),

        ChangeNotifierProvider(create: (_) => PolicyProvider()),
        ChangeNotifierProvider(create: (_) => CoLivingProvider()),
        ChangeNotifierProvider(create: (_) => ProfileEditProvider()),
        ChangeNotifierProvider(create: (_) => PhonePrivacyProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          elevation: 0,
        ),
      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int? screenIndex;
  const MyHomePage({super.key, this.screenIndex});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctr = Provider.of<HomeScreenProvicer>(context, listen: false);
      ctr.toggelPage(widget.screenIndex ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ctr = Provider.of<HomeScreenProvicer>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: AppColors.background,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomBottomNavBar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.mainColors,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(30),
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

          child: Icon(Icons.add, size: 24, color: AppColors.white),
        ),
        body: IndexedStack(index: ctr.pageIndex, children: ctr.screenPage),
      ),
    );
  }
}
