import 'package:fashion_app/widgets/build_carousel.dart';
import 'package:fashion_app/widgets/build_categories.dart';
import 'package:fashion_app/widgets/build_popular_products.dart';
import 'package:fashion_app/widgets/build_search.dart';
import 'package:fashion_app/widgets/build_trending_products.dart';
import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
  MobileLayout({Key? key}) : super(key: key);

  final TextStyle style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildSearchFields(),
        SizedBox(height: 20),
        BuildCarousel(),
        SizedBox(height: 20),
        BuildCategories(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Text(
                'Popular: ',
                style: style,
              ),
              Spacer(),
              Text('View All'),
            ],
          ),
        ),
        SizedBox(height: 10),
        BuildPopularProducts(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            'New Arrival Products',
            style: style,
          ),
        ),
        SizedBox(height: 10),
        // Center(
        //   child: Text(token),
        // ),
        BuildTrendingProducts(),
      ],
    );
  }
}
