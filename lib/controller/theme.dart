import 'package:fashion_app/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  Rx<ThemeData> currentTheme = Rx<ThemeData>(lightTheme);

  void setTheme(ThemeData theme) {
    currentTheme.value = theme;
    update();
  }
}
