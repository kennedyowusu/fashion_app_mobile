import 'package:fashion_app/layout.dart';
import 'package:fashion_app/views/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final box = GetStorage();
  runApp(FashionApp(loggedIn: box.read('loggedIn') ?? false));
}

class FashionApp extends StatelessWidget {
  final bool loggedIn;

  const FashionApp({required this.loggedIn, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fashion Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: loggedIn ? const MainLayout() : const AuthSelector(),
    );
  }
}
