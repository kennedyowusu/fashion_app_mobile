import 'package:carousel_slider/carousel_slider.dart';
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSearchField(),
              SizedBox(height: 20),
              Center(
                child: Text(token),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildSearchField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          icon: Icon(Icons.search),
        ),
      ),
    );
  }
}
