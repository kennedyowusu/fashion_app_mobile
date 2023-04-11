import 'package:fashion_app/views/recommendation/personalized_recommendation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
  box.read('currentUserId');
  runApp(FashionApp(isUserLoggedIn: token.isNotEmpty));
}

class FashionApp extends StatelessWidget {
  final bool isUserLoggedIn;

  const FashionApp({required this.isUserLoggedIn, Key? key}) : super(key: key);

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
      // home: isUserLoggedIn ? const MainLayout() : AuthSelector(),
      home: PersonalizedRecommendationsScreen(
        recentPurchases: ["recent 1, recent 2, recent 3"],
      ),
    );
  }
}
