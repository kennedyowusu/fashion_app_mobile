import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashion_app/controller/product.dart';
import 'package:fashion_app/model/products.dart';
import 'package:fashion_app/views/details/details.dart';
import 'package:fashion_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildCarousel extends StatelessWidget {
  BuildCarousel({super.key, required this.height});

  final double height;

  final ProductsController productController = Get.put(ProductsController());

  // create a list of colors
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return productController.isLoading.value
            ? Loader()
            : GestureDetector(
                onTap: () {
                  Get.to(
                    () => ProductDetailsScreen(
                      product: productController.products.firstWhere(
                        (element) => element.isFeatured == Is.YES,
                      ),
                    ),
                  );
                },
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: height,
                    viewportFraction: 0.8,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: productController.products.length > 1
                        ? Curves.fastOutSlowIn
                        : Curves.linear,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: [
                    ...productController.products.where(
                      (element) => element.isFeatured == Is.YES,
                    )
                  ].map(
                    (i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              // color: colors[images.indexOf(i)].withOpacity(0.5),
                              color: colors[
                                      productController.products.indexOf(i) %
                                          colors.length]
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Image.network(
                              i.image,
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      );
                    },
                  ).toList(),
                ),
              );
      },
    );
  }
}
