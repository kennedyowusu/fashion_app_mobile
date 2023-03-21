import 'package:flutter/material.dart';

class Config {
  Config();

  static MediaQueryData? mediaQueryData;
  static double screenWidth = 0;
  static double screenHeight = 0;

  Config._();

  //width and height initialization
  static void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData!.size.width;
    screenHeight = mediaQueryData!.size.height;
  }

  static double get widthSize {
    return screenWidth;
  }

  static double get heightSize {
    return screenHeight;
  }

  //define spacing height
  static const spaceSmall = SizedBox(
    height: 25,
  );
  static const spaceBig = SizedBox(
    height: 0.08,
  );

  //Text Form Field border
  static const outlinedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static const focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(
      color: Color(0xFF4682B4),
    ),
  );

  static const errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(
      color: Colors.red,
    ),
  );

  static const primaryColor = Color(0xFFF9A826);

  Padding buildPopularPadding(
      {required String text, String otherText = 'View All'}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          if (otherText.isNotEmpty) Text(otherText),
        ],
      ),
    );
  }
}
