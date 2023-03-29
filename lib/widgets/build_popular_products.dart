import 'package:fashion_app/controller/product.dart';
import 'package:fashion_app/model/products.dart';
import 'package:fashion_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildPopularProducts extends StatelessWidget {
  BuildPopularProducts({
    super.key,
    required this.height,
    required this.width,
    required this.responsiveHeight,
  });

  final double height, responsiveHeight;
  final double width;

  final ProductsController productController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: responsiveHeight,
      child: Obx(
        () {
          final popularProducts = productController.products
              .where((product) => product.isPopular == Is.YES)
              .toList();

          return productController.isLoading.value
              ? Loader()
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: popularProducts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 140,
                      margin: const EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: height,
                                width: width,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  // color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey[300]!,
                                  ),
                                ),
                                child: Image.network(
                                  popularProducts[index].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // SizedBox(height: 10),
                              Text(
                                popularProducts[index].name,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
