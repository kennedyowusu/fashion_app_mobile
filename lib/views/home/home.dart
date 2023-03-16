import 'package:fashion_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token') ?? '';

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Fashion Shop',
      ),
      body: SafeArea(
        child: Center(
          child: Text(token),
        ),
      ),
    );
  }
}
