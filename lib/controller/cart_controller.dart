import 'package:fashion_app/model/cart.dart';
import 'package:fashion_app/services/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartService _cartService = CartService();

  // List of cart items
  final RxList<CartModel> cartItems = RxList<CartModel>([]);
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  // Get cart items
  Future<void> fetchCartItems() async {
    try {
      isLoading(true);
      final cartItems = await _cartService.getCartItems();
      this.cartItems.assignAll(cartItems);
      debugPrint('Cart items: ${this.cartItems.length}');
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
          'Item added to cart', 'Your item has been added to the cart.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add item to cart: $e');
    }
  }

  void decrementQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    }
    update();
  }

  void incrementQuantity(int index) {
    cartItems[index].quantity++;
    update();
  }

  // Remove item from cart
  // Future<void> removeItemFromCart(int itemId) async {
  //   try {
  //     await _cartService.removeItemFromCart(itemId);
  //     cartItems.removeWhere((item) => item.id == itemId);
  //     Get.snackbar('Item removed from cart',
  //         'Your item has been removed from the cart.');
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to remove item from cart: $e');
  //   }
  // }
}
