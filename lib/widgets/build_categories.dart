import 'package:flutter/material.dart';

class BuildCategories extends StatelessWidget {
  const BuildCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.access_alarm),
                ),
                // SizedBox(height: 10),
                // Text('Category $index'),
              ],
            ),
          );
        },
      ),
    );
  }
}