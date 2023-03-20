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
              buildCarouselSlider(),
              SizedBox(height: 20),
              buildCategories(),
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

  buildCarouselSlider() {
    return SizedBox(
      height: 200,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200,
          viewportFraction: 0.8,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: [
          'Hello',
          'World',
          'Kennedy',
          'Kenny',
          'Kendrick',
        ].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5),
                ),
                // child: Image.asset(
                //   i,
                //   fit: BoxFit.cover,
                // ),
                child: Text(i),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  buildCategories() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.access_alarm),
                ),
                SizedBox(height: 10),
                Text('Category $index'),
              ],
            ),
          );
        },
      ),
    );
  }
}
