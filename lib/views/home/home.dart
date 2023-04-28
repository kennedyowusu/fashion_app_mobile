import 'package:fashion_app/constants/theme_data.dart';
import 'package:fashion_app/controller/theme.dart';
import 'package:fashion_app/helper/build_product_cart.dart';
import 'package:fashion_app/responsive/desktop.dart';
import 'package:fashion_app/responsive/mobile.dart';
import 'package:fashion_app/responsive/tablet.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Fashion Shop',
        actions: [
          buildProductCart(),
          SizedBox(width: 5.0),
          buildThemeChanger(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth < 600) {
                // mobile
                return MobileLayout();
              } else if (constraints.maxWidth < 900) {
                // tablet
                return TabletDesktopLayout();
              } else {
                // desktop
                return DeskTopLayout();
              }
            },
          ),
        ),
      ),
    );
  }

  buildThemeChanger() {
    final themeController = Get.find<ThemeController>();

    return Padding(
      padding: const EdgeInsets.only(
        right: 10.0,
        bottom: 2.0,
      ),
      child: IconButton(
        icon: Icon(
          Icons.brightness_4,
          color: Colors.black,
          size: 30,
        ),
        onPressed: () {
          final isDarkMode =
              themeController.currentTheme.value.brightness == Brightness.dark;
          final newTheme = isDarkMode ? lightTheme : darkTheme;
          themeController.setTheme(newTheme);
        },
      ),
    );
  }
}
