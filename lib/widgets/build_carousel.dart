import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BuildCarousel extends StatelessWidget {
  const BuildCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
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
    );
  }
}