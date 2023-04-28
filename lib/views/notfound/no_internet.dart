import 'package:fashion_app/helper/connectivity_result.dart';
import 'package:fashion_app/widgets/button.dart';
import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  final String message;

  const NoInternetScreen({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off,
                  size: 200,
                  color: Colors.black,
                ),
                SizedBox(height: 26),
                Text(
                  message.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Button(
                  title: 'Refresh',
                  onPressed: () {
                    checkInternetConnectivity(context);
                  },
                  disable: false,
                  width: double.infinity,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
