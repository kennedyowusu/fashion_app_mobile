import 'package:fashion_app/controller/categories.dart';
import 'package:fashion_app/controller/category_products.dart';
import 'package:fashion_app/views/details/product_by_category_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BuildCategories extends StatelessWidget {
  BuildCategories({super.key, required this.rightPadding});
  final double rightPadding;

  final CategoriesController categoriesController =
      Get.put(CategoriesController());

  final ProductsByCategoryController categoryProductsController =
      Get.put(ProductsByCategoryController());

  @override
  Widget build(BuildContext context) {
    debugPrint(
        "BuildCategories: ${categoryProductsController.productByCategory.length}");
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5.0,
      ),
      height: 40,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: categoriesController.categories.length,
        itemBuilder: (context, index) {
          return Obx(
            () => GestureDetector(
              onTap: () {
                GetStorage().write(
                    'categoryId', categoriesController.categories[index].id);

                Get.to(
                  () => ProductsByCategoryScreen(
                    categoryId: categoriesController.categories[index].id,
                    categoryName: categoriesController.categories[index].name,
                  ),
                );

                // if (categoryProductsController.productByCategory.isNotEmpty) {
                //   Get.to(
                //     () => ProductsByCategoryScreen(
                //       categoryId: categoriesController.categories[index].id,
                //       categoryName: categoriesController.categories[index].name,
                //     ),
                //   );
                // } else {
                //   debugPrint("The list is empty");
                // }
                print(
                  "Category ID: ${categoriesController.categories[index].id}",
                );
              },
              child: Container(
                height: 40,
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                margin: EdgeInsets.only(right: rightPadding * 2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1.0,
                  ),
                ),
                child: Text(
                  categoriesController.categories[index].name,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
