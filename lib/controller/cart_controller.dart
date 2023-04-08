import 'package:fashion_app/model/cart.dart';
import 'package:fashion_app/model/products.dart';
import 'package:fashion_app/services/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  final CartService _cartService = CartService();

  final RxList<CartModel> cartItems = RxList<CartModel>([]);
  final RxBool isLoading = true.obs;

  final RxDouble totalAmount = 0.0.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
    final storedTotalAmount = box.read('totalAmount');
    if (storedTotalAmount != null) {
      totalAmount(storedTotalAmount.toDouble());
    }
  }

  Future<void> fetchCartItems() async {
    try {
      isLoading(true);
      final cartItems = await _cartService.getCartItems();
      this.cartItems.assignAll(cartItems);
      // Check if cart is empty and show message if it is
      if (cartItems.isEmpty) {
        Get.snackbar('Empty Cart', 'Your cart is empty.');
      }
      debugPrint('Cart items from Controller: ${cartItems.length}');
      updateTotalAmount();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch cart items: $e');
    } finally {
      isLoading(false);
    }
  }

  void addToCart(Product product, int quantity) {
    try {
      final existingItemIndex =
          cartItems.indexWhere((item) => item.productId == product.id);
      if (existingItemIndex != -1) {
        final existingItem = cartItems[existingItemIndex];
        final updatedItem = existingItem.copyWith(
          quantity: existingItem.quantity + quantity,
          totalPrice: existingItem.totalPrice + (product.price * quantity),
        );
        cartItems[existingItemIndex] = updatedItem;
      } else {
        final newItem = CartModel(
          id: DateTime.now().millisecondsSinceEpoch,
          name: product.name,
          image: product.image,
          price: product.price,
          quantity: quantity,
          userId: 1,
          productId: product.id,
          totalPrice: product.price * quantity,
        );
        cartItems.add(newItem);
      }
      // Update total amount
      final newTotalAmount = cartItems.fold(
        0.0,
        (total, item) => total + item.totalPrice,
      );
      totalAmount(newTotalAmount);
      // Save total amount to local storage
      box.write('totalAmount', newTotalAmount);
      // Save cart items to server
      _cartService.saveCartItems(cartItems.toList());
      debugPrint('Cart items from Cart Controller: ${cartItems.length}');
    } catch (e) {
      print(e);
    }
  }

  void decrementQuantity(int index) {
    if (cartItems[index].quantity >= 1) {
      cartItems[index].quantity--;
      updateTotalAmount();
    } else {
      removeCartItem(index);
    }
    update();
  }

  void incrementQuantity(int index) {
    cartItems[index].quantity++;
    updateTotalAmount();
    update();
  }

  void updateTotalAmount() {
    final newTotalAmount = cartItems.fold(
      0.00,
      (previousValue, element) =>
          previousValue + (element.price * element.quantity),
    );
    totalAmount(newTotalAmount.toDouble());
    box.write('totalAmount', newTotalAmount);
  }

  void removeCartItem(int index) {
    final removedItem = cartItems.removeAt(index);
    Get.snackbar(
      'Item removed from cart',
      '${removedItem.name} has been removed from the cart.',
    );
    updateTotalAmount();
  }
}
