import 'package:fashion_app/views/auth/auth.dart';
import 'package:fashion_app/views/no_inernet/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:connectivity/connectivity.dart';

import 'layout.dart';

/*
  Read the user's token from GetStorage. If the token is not empty,
  it means the user is logged in so set the isUserLoggedIn variable to true.
  Then pass this value to the FashionApp widget,
  which then decides which screen to show based on the isUserLoggedIn variable.
**/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final box = GetStorage();
  // box.remove('token');
  final token = box.read('token') ?? '';
  final currentUserId = box.read('currentUserId');
  final shippingAddressId = box.read('shippingAddress');
  final shippingAddress = box.read('shippingAddress');
  debugPrint('Shipping Address: $shippingAddress');
  debugPrint('Token: $token');
  debugPrint('Shipping Address ID: $shippingAddressId');
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

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
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
    return GetMaterialApp(
      title: 'Fashion Shop',
      debugShowCheckedModeBanner: false,
      transitionDuration: const Duration(milliseconds: 500),
      defaultTransition: Transition.fade,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: hasInternetConnection
          ? widget.isUserLoggedIn
              ? const MainLayout()
              : AuthSelector()
          : NoInternetScreen(
              message: 'No internet Connection.',
            ),
    );
  }
}
