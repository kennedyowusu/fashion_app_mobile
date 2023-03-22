import 'package:fashion_app/helper/config.dart';
import 'package:fashion_app/widgets/build_carousel.dart';
import 'package:fashion_app/widgets/build_categories.dart';
import 'package:fashion_app/widgets/build_popular_products.dart';
import 'package:fashion_app/widgets/build_search.dart';
import 'package:fashion_app/widgets/build_trending_products.dart';
import 'package:flutter/material.dart';

class DeskTopLayout extends StatelessWidget {
  DeskTopLayout({Key? key}) : super(key: key);

  final TextStyle style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  final Config config = Config();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: 10),
        BuildSearchFields(),
        SizedBox(height: 20),
        BuildCarousel(
          height: 400.0,
        ),
        SizedBox(height: 20),
        BuildCategories(
          rightPadding: 20,
        ),
        config.buildPopularPadding(
          text: 'Popular: ',
        ),
        SizedBox(height: 10, width: 25),
        BuildPopularProducts(
          height: height * 0.200,
          width: width * 0.200,
          responsiveHeight: height * 0.250,
        ),
        SizedBox(height: 10),
        config.buildPopularPadding(
          text: 'New Arrival Products: ',
        ),
        SizedBox(height: 10),
        BuildTrendingProducts(
          height: 120.0,
          width: 120.0,
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
