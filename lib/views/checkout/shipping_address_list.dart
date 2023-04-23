import 'package:fashion_app/controller/shipping_address.dart';
import 'package:fashion_app/helper/config.dart';
import 'package:fashion_app/model/shipping_address.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:fashion_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ShippingAddressList extends StatelessWidget {
  final ShippingAddressController shippingAddressService =
      Get.put(ShippingAddressController());

  final ShippingAddressController shippingAddressController =
      Get.put(ShippingAddressController());

  ShippingAddressList({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint(
      'Shipping Address List: ${shippingAddressController.shippingAddress.length}',
    );
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Shipping Address',
        leadingIcon: FaIcon(
          FontAwesomeIcons.chevronLeft,
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Icon(
                Icons.favorite_border,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Obx(
            () => shippingAddressController.isLoading.value
                ? Center(
                    child: Loader(),
                  )
                : shippingAddressController.shippingAddress.isEmpty
                    ? Center(
                        child: Text('No Shipping Addresses found'),
                      )
                    : ListView.builder(
                        itemCount:
                            shippingAddressController.shippingAddress.length,
                        itemBuilder: (context, index) {
                          ShippingAddress address =
                              shippingAddressController.shippingAddress[index];
                          return Container(
                            height: 100,
                            width: double.infinity,
                            margin: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Config.primaryColor,
                            ),
                            child: ListTile(
                              title: Text(
                                address.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '${address.addressLine1}, ${address.city} ${address.state} ${address.zip}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              trailing: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                                child: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    // Navigate to Edit Shipping Address screen
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ),
      ),
    );
  }
}
