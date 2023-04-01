import 'package:fashion_app/constants/images.dart';
import 'package:fashion_app/controller/category_products.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../model/products.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  const ProductsByCategoryScreen(
      {super.key, required this.categoryId, required this.categoryName});

  final int categoryId;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final productsByCategoryController = Get.put(
      ProductsByCategoryController(categoryId: categoryId),
    );

    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: FaIcon(
          FontAwesomeIcons.chevronLeft,
          color: Colors.black,
        ),
        title: categoryName,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.shopping_cart),
              ),
              Positioned(
                top: 0,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '0',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () {
            final products = productsByCategoryController.productByCategory;
            final isLoading = productsByCategoryController.isLoading.value;

            if (products.isEmpty && !isLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      ProjectImages().no_product,
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'This Category has no products yet.'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Stack(
                children: [
                  if (isLoading) Center(child: CircularProgressIndicator()),
                  if (!isLoading)
                    ListView.separated(
                      itemCount: products.length,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 80,
                                child: Hero(
                                  tag: product.id,
                                  child: Image.network(
                                    product.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'GHS ${product.price}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.orange,
                                child: Center(
                                  child: IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.cartPlus,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    onPressed: () {
                                      // productsByCategoryController
                                      //     .addToCart(product);
                                      debugPrint(product.name);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
