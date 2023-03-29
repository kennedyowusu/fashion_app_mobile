import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashion_app/widgets/project_images.dart';
import 'package:flutter/material.dart';

class BuildCarousel extends StatelessWidget {
  BuildCarousel({super.key, required this.height});

  final double height;

  // create a list of colors
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        viewportFraction: 0.8,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: [
        ...images,
      ].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: colors[images.indexOf(i)].withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Image.asset(
                i.toString(),
                fit: BoxFit.contain,
              ),
              // child: i,
            );
          },
        );
      }).toList(),
    );
  }
}
