import 'package:fashion_app/widgets/build_product_list.dart';
import 'package:flutter/material.dart';

class PopularProductsScreen extends StatelessWidget {
  const PopularProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductListScreen(
      isPopular: true,
      isFeatured: false,
    );
  }
}
