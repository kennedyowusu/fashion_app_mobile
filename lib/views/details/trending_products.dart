import 'package:fashion_app/widgets/build_product_list.dart';
import 'package:flutter/material.dart';

class TrendingProductsScreen extends StatelessWidget {
  const TrendingProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductListScreen(
      isPopular: false,
      isFeatured: true,
    );
  }
}
