import 'package:fashion_app/model/cart.dart';
import 'package:fashion_app/services/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  final CartService _cartService = CartService();

  // List of cart items
  final RxList<CartModel> cartItems = RxList<CartModel>([]);
  final RxBool isLoading = true.obs;

  // Total cart amount
  final RxDouble totalAmount = 0.0.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
    // Get the stored total cart amount from local storage
    final storedTotalAmount = box.read('totalAmount');
    if (storedTotalAmount != null) {
      totalAmount(storedTotalAmount);
    }
  }

  // Get cart items
  Future<void> fetchCartItems() async {
    try {
      isLoading(true);
      final cartItems = await _cartService.getCartItems();
      this.cartItems.assignAll(cartItems);
      debugPrint('Cart items: ${this.cartItems.length}');
      // Update the total cart amount
      updateTotalAmount();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch cart items: $e');
      debugPrint('Failed to fetch cart items: $e');
    } finally {
      isLoading(false);
    }
  }

  // Add item to cart
  Future<void> addItemToCart(String cartId, CartModel cartItem) async {
    try {
      final addedItem = await _cartService.addItemToCart(cartId, cartItem);
      cartItems.add(addedItem);
      Get.snackbar(
        'Item added to cart',
        'Your item has been added to the cart.',
      );
      // Update the total cart amount
      updateTotalAmount();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add item to cart: $e');
    }
  }

  void decrementQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      // Update the total cart amount
      updateTotalAmount();
    }
    update();
  }

  void incrementQuantity(int index) {
    cartItems[index].quantity++;
    // Update the total cart amount
    updateTotalAmount();
    update();
  }

  // Calculate and store the total cart amount
  void updateTotalAmount() {
    final newTotalAmount = cartItems.fold(
      0,
      (previousValue, element) =>
          previousValue + (element.price * element.quantity),
    );
    totalAmount(newTotalAmount.toDouble());
    box.write('totalAmount', newTotalAmount);
  }
}
