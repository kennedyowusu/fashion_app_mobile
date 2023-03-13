import 'package:fashion_app/views/home/home.dart';
import 'package:fashion_app/views/orders/orders.dart';
import 'package:fashion_app/views/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late final PageController _page;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _page = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _page,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        children: <Widget>[
          HomeView(),
          OrdersView(),
          ProfileView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (page) {
          currentPage = page;
          _page.animateToPage(
            page,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.heart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
