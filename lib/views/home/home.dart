import 'package:fashion_app/helper/build_product_cart.dart';
import 'package:fashion_app/responsive/desktop.dart';
import 'package:fashion_app/responsive/mobile.dart';
import 'package:fashion_app/responsive/tablet.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Fashion Shop',
        actions: [
          buildProductCart(),
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
}
