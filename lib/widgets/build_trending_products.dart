import 'package:flutter/material.dart';

class BuildTrendingProducts extends StatelessWidget {
  const BuildTrendingProducts({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
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
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.access_alarm),
                    ),
                    SizedBox(height: 10),
                    Text('Product $index'),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
