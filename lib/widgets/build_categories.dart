import 'package:fashion_app/controller/categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildCategories extends StatelessWidget {
  BuildCategories({super.key, required this.rightPadding});
  final double rightPadding;

  final CategoriesController categoriesController =
      Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 60,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: categoriesController.categories.length,
        itemBuilder: (context, index) {
          return Obx(
            () => Container(
              margin: EdgeInsets.only(right: rightPadding),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
