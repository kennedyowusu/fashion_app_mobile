import 'package:fashion_app/controller/theme.dart';
import 'package:fashion_app/views/auth/auth.dart';
import 'package:fashion_app/views/notfound/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'layout.dart';

/*
  Read the user's token from GetStorage. If the token is not empty,
  it means the user is logged in so set the isUserLoggedIn variable to true.
  Then pass this value to the FashionApp widget,
  which then decides which screen to show based on the isUserLoggedIn variable.
**/

void main() async {
  // Ensure that Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  final box = GetStorage();
  // box.remove('token');
  final token = box.read('token') ?? '';
  final currentUserId = box.read('currentUserId');
  // final shippingAddressId = box.read('shippingAddress');
  final shippingAddress = box.read('shippingAddress');
  debugPrint('Shipping Address: $shippingAddress');
  debugPrint('Token: $token');
  // debugPrint('Shipping Address ID: $shippingAddressId');
  debugPrint(currentUserId);
  runApp(FashionApp(isUserLoggedIn: token.isNotEmpty));
}

class FashionApp extends StatefulWidget {
  final bool isUserLoggedIn;

  const FashionApp({required this.isUserLoggedIn, Key? key}) : super(key: key);

  @override
  _FashionAppState createState() => _FashionAppState();
}

class _FashionAppState extends State<FashionApp> {
  bool hasInternetConnection = true;
  String appVersion = '';

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    checkAppVersion();
  }

  Future<void> checkAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    debugPrint('App Version: $appVersion');

    // Perform any version-specific actions or checks here
    if (appVersion == '1.0.0') {
      // Execute code specific to version 1.0.0
      debugPrint('Performing actions for version 1.0.0...');
      // ...
    } else if (appVersion == '2.0.0') {
      // Execute code specific to version 2.0.0
      debugPrint('Performing actions for version 2.0.0...');
      // ...
    } else {
      // Handle other app versions
      debugPrint('Performing actions for other app versions...');
      // ...
    }
  }

  Future<void> checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        hasInternetConnection = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: ThemeController(),
      builder: (controller) {
        final currentTheme = controller.currentTheme.value;
        return GetMaterialApp(
          title: 'Fashion Shop',
          debugShowCheckedModeBanner: false,
          transitionDuration: const Duration(milliseconds: 500),
          defaultTransition: Transition.fade,
          theme: currentTheme,
          home: hasInternetConnection
              ? widget.isUserLoggedIn
                  ? const MainLayout()
                  : AuthSelector()
              : NoInternetScreen(
                  message: 'No internet Connection.',
                ),

          // home: PaymentScreen(),
        );
      },
    );
  }
}
