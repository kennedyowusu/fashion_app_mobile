import 'package:fashion_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonalizedRecommendationsScreen extends StatelessWidget {
  final List<String> recentPurchases; // list of recent purchases by the user

  PersonalizedRecommendationsScreen({super.key, required this.recentPurchases});

  // dummy list of recommended items
  final List<String> recommendedItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Personalized Recommendations',
        leadingIcon: FaIcon(
          FontAwesomeIcons.chevronLeft,
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Icon(
                Icons.favorite_border,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Based on your recent purchases:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: recentPurchases
                  .map(
                    (item) => Chip(
                      label: Text(item),
                      backgroundColor: Colors.grey[300],
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 32.0),
            Text(
              'You may also like:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: recommendedItems
                    .map(
                      (item) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.grey[300],
                        ),
                        child: Center(
                          child: Text(
                            item,
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
