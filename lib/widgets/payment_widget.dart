import 'package:fashion_app/controller/payment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentExpansionTile extends StatelessWidget {
  PaymentExpansionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.child,
    required this.color,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;
  final Color color;

  final PaymentController controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[200],
      ),
      child: ExpansionTile(
        backgroundColor: Colors.white,
        leading: Icon(icon),
        title: Text(
          title.toUpperCase(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        onExpansionChanged: (bool expanded) {
          controller.toggle();
        },
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  subtitle,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
