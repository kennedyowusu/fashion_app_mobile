import 'package:fashion_app/helper/config.dart';
import 'package:fashion_app/views/details/popular_products.dart';
import 'package:fashion_app/views/details/trending_products.dart';
import 'package:fashion_app/widgets/build_carousel.dart';
import 'package:fashion_app/widgets/build_categories.dart';
import 'package:fashion_app/widgets/build_popular_products.dart';
import 'package:fashion_app/widgets/build_search.dart';
import 'package:fashion_app/widgets/build_trending_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileLayout extends StatelessWidget {
  MobileLayout({Key? key}) : super(key: key);

  final TextStyle style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  final Config config = Config();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        BuildSearchFields(),
        SizedBox(height: 20),
        BuildCarousel(
          height: 200,
        ),
        SizedBox(height: 20),
        config.buildPopularPadding(
          text: 'Categories',
          otherText: "",
        ),
        SizedBox(height: 10),
        BuildCategories(
          rightPadding: 10,
        ),
        SizedBox(height: 10),
        config.buildPopularPadding(
          text: 'Popular ',
          onTap: () {
            Get.to(
              () => PopularProductsScreen(),
            );
          },
        ),
        SizedBox(height: 10),
        BuildPopularProducts(
          responsiveHeight: height * 0.190,
          height: 100.0,
          width: 100.0,
        ),
        config.buildPopularPadding(
          text: 'New Arrivals',
          onTap: () => Get.to(
            () => TrendingProductsScreen(),
          ),
        ),
        SizedBox(height: 10),
        BuildTrendingProducts(
          height: 100.0,
          width: 100.0,
        ),
      ],
    );
  }
}
