import 'package:fashion_app/responsive/desktop.dart';
import 'package:fashion_app/responsive/mobile.dart';
import 'package:fashion_app/responsive/tablet.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token') ?? '';

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Fashion Shop',
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.shopping_cart),
              ),
              Positioned(
                top: 0,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '0',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
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
