import 'package:fashion_app/controller/shipping_address.dart';
import 'package:fashion_app/helper/config.dart';
import 'package:fashion_app/model/shipping_address.dart';
import 'package:fashion_app/views/checkout/checkout.dart';
import 'package:fashion_app/views/notfound/no_shipping_address.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:fashion_app/widgets/button.dart';
import 'package:fashion_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ShippingAddressList extends StatelessWidget {
  final ShippingAddressController shippingAddressService =
      Get.put(ShippingAddressController());

  final ShippingAddressController shippingAddressController =
      Get.put(ShippingAddressController());

  final box = GetStorage();

  ShippingAddressList({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint(
      'Shipping Address List: ${shippingAddressController.shippingAddress.length}',
    );
    final addresses = box.read('shippingAddress');

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
                        child: NoShippingAddressesFound(),
                      )
                    : RefreshIndicator(
                        onRefresh: () {
                          return shippingAddressController
                              .refreshShippingAddress();
                        },
                        child: ListView.builder(
                          itemCount:
                              shippingAddressController.shippingAddress.length,
                          itemBuilder: (context, index) {
                            ShippingAddress address = shippingAddressController
                                .shippingAddress[index];
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
      ),
      bottomNavigationBar: addresses is List && addresses.length > 5
          ? BottomAppBar(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Text(
                    'delete one address to add new one'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          : Container(
              height: 54.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Button(
                onPressed: () {
                  // Navigate to Add Shipping Address screen
                  Get.to(
                    () => CheckoutScreen(),
                    transition: Transition.rightToLeft,
                  );
                },
                title: 'Add New Address',
                disable: false,
                width: double.infinity,
              ),
            ),
    );
  }
}
