import 'package:fashion_app/controller/product.dart';
import 'package:fashion_app/model/products.dart';
import 'package:fashion_app/views/details/details.dart';
import 'package:fashion_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildTrendingProducts extends StatelessWidget {
  BuildTrendingProducts({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  final ProductsController productController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final newProducts = productController.products
            .where((product) => product.isNew == Is.YES)
            .toList();

        return productController.isLoading.value
            ? Loader()
            : Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newProducts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => ProductDetailsScreen(
                            product: newProducts[index],
                          ),
                        );
                      },
                      child: Container(
                        height: 150,
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
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                  child: Image.network(
                                    newProducts[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  newProducts[index].name.length > 15
                                      ? '${newProducts[index].name.substring(0, 10)}...'
                                      : newProducts[index].name,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}
