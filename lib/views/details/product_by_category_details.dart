import 'package:fashion_app/controller/category_products.dart';
import 'package:fashion_app/model/product_by_category.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  const ProductsByCategoryScreen(
      {super.key, required this.categoryId, required this.categoryName});

  final int categoryId;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final productsByCategoryController =
        Get.put(ProductsByCategoryController());

    return Scaffold(
      appBar: CustomAppBar(
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
      body: Container(
        padding: EdgeInsets.all(16),
        child: Obx(() {
          if (productsByCategoryController.productByCategory.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: productsByCategoryController.productByCategory.length,
              itemBuilder: (context, index) {
                ProductModel product =
                    productsByCategoryController.productByCategory[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.description),
                  // trailing: Text('\$${product.price.toStringAsFixed(2)}'),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
