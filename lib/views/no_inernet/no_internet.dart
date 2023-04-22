import 'package:fashion_app/constants/images.dart';
import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  final String message;

  const NoInternetScreen({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ProjectImages.NOINTERNET,
              width: 150,
            ),
            SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add logic to try to reconnect to the internet
              },
              child: Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
