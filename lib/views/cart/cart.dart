import 'package:fashion_app/controller/cart_controller.dart';
import 'package:fashion_app/controller/shipping_address.dart';
import 'package:fashion_app/model/products.dart';
import 'package:fashion_app/services/shipping_Address.dart';
import 'package:fashion_app/views/checkout/checkout.dart';
import 'package:fashion_app/views/checkout/shipping_address_list.dart';
import 'package:fashion_app/views/home/home.dart';
import 'package:fashion_app/widgets/custom_snackbar.dart';
import 'package:fashion_app/widgets/empty_screen.dart';
import 'package:fashion_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key, this.product}) : super(key: key);

  final CartController cartController = Get.put(CartController());
  final box = GetStorage();
  final Product? product;
  final ShippingAddressController shippingAddressController =
      Get.put(ShippingAddressController());

  @override
  Widget build(BuildContext context) {
    final cartItems = cartController.cartItems;
    return Scaffold(
      backgroundColor: cartItems.isEmpty ? Colors.white : Colors.grey[200],
      appBar: AppBar(
        title: Text('Cart Items'),
        backgroundColor: Colors.white,
        leading: Container(
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
                Get.off(() => HomeView());
              },
              icon: FaIcon(
                FontAwesomeIcons.chevronLeft,
                color: Colors.black,
                size: 16.0,
              ),
            ),
          ),
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
      body: Obx(
        () {
          if (cartController.isLoading.value) {
            return Center(child: Loader());
          } else if (cartItems.isEmpty) {
            return EmptyScreen(
              message: 'Your cart is Empty',
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                await cartController.loadCart();
              },
              child: ListView.separated(
                itemCount: cartItems.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final cartItem = cartItems[index];
                  TextStyle textStyle = TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  );
                  return Dismissible(
                    key: Key(cartItem.id.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) async {
                      await cartController.removeItemFromCart(cartItem.id);
                      cartController.cartItems.removeAt(index);
                      CustomSnackbar.show(
                        'Success',
                        '${cartItem.name} has been removed from the cart',
                      );
                    },
                    background: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Expanded(
                          //   flex: 2,
                          //   child: Image.network(cartItem.image),
                          // ),
                          SizedBox(width: 16.0),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartItem.name,
                                  style: textStyle,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _buildRoundIconButton(
                                      icon: Icon(
                                        Icons.remove,
                                        size: 18.0,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        // cartController.decrementQuantity(index);
                                        cartController.updateCartItemQuantity(
                                          index,
                                          cartItems[index].quantity - 1,
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      // cartItem.quantity.toString(),
                                      cartItems[index].quantity.toString(),
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    _buildRoundIconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 18.0,
                                      ),
                                      onPressed: () {
                                        // cartController.incrementQuantity(index);
                                        cartController.updateCartItemQuantity(
                                            index,
                                            cartItems[index].quantity + 1);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              '₵${(cartItem.totalPrice.toStringAsFixed(0))}',
                              textAlign: TextAlign.right,
                              style: textStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
      bottomNavigationBar: cartController.cartItems.isEmpty
          ? Text("")
          : BottomAppBar(
              child: Container(
                height: 54.0,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        'Total: ₵${cartController.totalAmount.value.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        if (shippingAddressController
                            .hasLocalShippingAddress()) {
                          Get.to(() => ShippingAddressList());
                          debugPrint('has shipping address');
                        } else {
                          Get.to(() => CheckoutScreen());
                          debugPrint('no shipping address');
                        }
                      },
                      child: Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildRoundIconButton({
    required Widget icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 35.0,
        height: 35.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        alignment: Alignment.center,
        child: icon,
      ),
    );
  }
}
