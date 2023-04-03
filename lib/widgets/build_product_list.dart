import 'package:fashion_app/controller/cart_controller.dart';
import 'package:fashion_app/controller/product.dart';
import 'package:fashion_app/helper/build_product_cart.dart';
import 'package:fashion_app/model/products.dart';
import 'package:fashion_app/views/details/details.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:fashion_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({
    Key? key,
    required this.isPopular,
    required this.isFeatured,
  }) : super(key: key);

  final bool isPopular;
  final bool isFeatured;

  @override
  Widget build(BuildContext context) {
    final ProductsController productController = Get.put(ProductsController());
    final CartController cartController = Get.put(CartController());

    return Scaffold(
      appBar: CustomAppBar(
        title: isPopular
            ? 'Popular Products'
            : isFeatured
                ? 'New Arrivals'
                : '',
        leadingIcon: FaIcon(
          FontAwesomeIcons.chevronLeft,
          color: Colors.black,
        ),
        actions: [
          buildProductCart(

          ),
        ],
      ),
      body: Obx(
        () {
          final products = productController.products
              .where((product) =>
                  (isPopular && product.isPopular == Is.YES) ||
                  (isFeatured && product.isFeatured == Is.YES))
              .toList();

          return productController.isLoading.value
              ? Loader()
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = products[index];
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          isPopular
                              ? Get.to(ProductDetailsScreen(product: product))
                              : Get.to(ProductDetailsScreen(product: product));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 80,
                              child: Image.network(
                                product.image,
                                fit: BoxFit.cover,
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
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  onPressed: () {
                                    // Handle adding to cart
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
