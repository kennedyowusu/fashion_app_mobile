import 'package:flutter/material.dart';

class BuildSearchFields extends StatelessWidget {
  const BuildSearchFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
