import 'package:fashion_app/helper/config.dart';
import 'package:fashion_app/widgets/build_carousel.dart';
import 'package:fashion_app/widgets/build_categories.dart';
import 'package:fashion_app/widgets/build_popular_products.dart';
import 'package:fashion_app/widgets/build_search.dart';
import 'package:fashion_app/widgets/build_trending_products.dart';
import 'package:flutter/material.dart';

class TabletDesktopLayout extends StatelessWidget {
  TabletDesktopLayout({super.key});

  final TextStyle style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  final Config config = Config();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        BuildSearchFields(),
        SizedBox(height: 20),
        BuildCarousel(
          height: 300.0,
        ),
        SizedBox(height: 20),
        BuildCategories(
          rightPadding: 20,
        ),
        config.buildPopularPadding(
          text: 'Popular: ',
        ),
        SizedBox(height: 10),
        BuildPopularProducts(height: 120.0, width: 120.0),
        SizedBox(height: 20),
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
