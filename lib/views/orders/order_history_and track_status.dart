import 'package:fashion_app/views/recommendation/personalized_recommendation.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:fashion_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class OrderHistoryAndTrackingOrderStatus extends StatelessWidget {
  const OrderHistoryAndTrackingOrderStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Order History & Tracking Order Status',
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
              'Order History',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Button(
              width: double.infinity,
              disable: false,
              title: 'View Order History',
              onPressed: () {
                // Navigate to the order history screen
              },
            ),
            SizedBox(height: 32.0),
            Text(
              'Track My Order',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Order Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Button(
              width: double.infinity,
              disable: false,
              title: 'Track Order',
              onPressed: () {
                // Track the status of the user's order
              },
            ),
            SizedBox(height: 32.0),
            Text(
              'Personalized Recommendations',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            // Display personalized recommendations based on the user's recent purchases
            // For example, you could use a GridView to display a list of recommended items

            Button(
              width: double.infinity,
              title: "View All",
              onPressed: () {
                Get.to(
                  () => PersonalizedRecommendationsScreen(
                    recentPurchases: [],
                  ),
                );
              },
              disable: false,
            )
          ],
        ),
      ),
    );
  }
}
