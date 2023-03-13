import 'package:fashion_app/widgets/appbar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Fashion Shop',
      ),
      body: SafeArea(
        child: Center(
          child: Text('Home View'),
        ),
      ),
    );
  }
}
