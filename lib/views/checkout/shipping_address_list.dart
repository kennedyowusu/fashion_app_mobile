import 'package:fashion_app/controller/shipping_address.dart';
import 'package:fashion_app/model/shipping_address.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:fashion_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ShippingAddressList extends StatelessWidget {
  final ShippingAddressController shippingAddressService =
      Get.put(ShippingAddressController());

  ShippingAddressList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Shipping Addresse',
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
            () => shippingAddressService.isLoading.value
                ? Center(
                    child: Loader(),
                  )
                : shippingAddressService.shippingAddress.isEmpty
                    ? Center(
                        child: Text('No Shipping Addresses found'),
                      )
                    : ListView.builder(
                        itemCount:
                            shippingAddressService.shippingAddress.length,
                        itemBuilder: (context, index) {
                          ShippingAddress address =
                              shippingAddressService.shippingAddress[index];
                          return ListTile(
                            title: Text(address.name),
                            subtitle: Text(
                              '${address.addressLine1}, ${address.city} ${address.state} ${address.zip}',
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Navigate to Edit Shipping Address screen
                              },
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
