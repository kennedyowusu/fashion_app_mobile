import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.navigateTo,
    this.leadingIcon,
    this.actions,
  }) : super(key: key);

  final String title;
  final String? navigateTo;
  final FaIcon? leadingIcon;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      leading: leadingIcon != null
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey[300]!,
                ),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    if (navigateTo != null) {
                      Navigator.of(context).pushNamed(navigateTo!);
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  icon: leadingIcon!,
                  iconSize: 16,
                  color: Colors.white,
                ),
              ),
            )
          : null,
      actions: actions,
    );
  }
}
