import 'package:fashion_app/controller/cart_controller.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cart Items',
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
      body: Obx(
        () => cartController.isLoading.value
            ? Center(
                child: Text('No items in cart'),
              )
            : Obx(
                () => ListView.separated(
                  itemCount: cartController.cartItems.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    final cartItem = cartController.cartItems[index];
                    TextStyle textStyle = TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    );
                    return Dismissible(
                      key: Key(cartItem.id.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        // Remove the item from the cart
                        // cartController.removeCartItem(index);
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
                            Expanded(
                              flex: 2,
                              child: Image.network(cartItem.image),
                            ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      _buildRoundIconButton(
                                        icon: Icon(
                                          Icons.remove,
                                          size: 18.0,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          cartController
                                              .decrementQuantity(index);
                                        },
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        cartItem.quantity.toString(),
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
                                          cartController
                                              .incrementQuantity(index);
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
                                '₵${(cartItem.price * cartItem.quantity)}',
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
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 54.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: ₵${cartController.cartItems.fold(
                  0,
                  (previousValue, element) =>
                      previousValue + (element.price * element.quantity),
                )}',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
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
