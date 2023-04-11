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

  final cartItemsCount = 0.obs;
  final updatingCart = false.obs;
  final addingToCartError = ''.obs;

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

  Future<void> loadCart() async {
    isLoading.value = true;
    final newCartItems = await _cartService.getCartItems();
    cartItems.clear(); // clear the existing items
    cartItems.addAll(newCartItems); // add the new items
    isLoading.value = false;
  }

  void addToCart(Product item) async {
    try {
      updatingCart(true);
      addingToCartError('');

      final existingItemIndex =
          cartItems.indexWhere((x) => x.productId == item.id);
      if (existingItemIndex != -1) {
        final existingItem = cartItems[existingItemIndex];
        final updatedItem = existingItem.copyWith(
          quantity: existingItem.quantity + 1,
          totalPrice: existingItem.totalPrice + item.price,
        );
        cartItems[existingItemIndex] = updatedItem;
      } else {
        cartItems.add(item as CartModel);
      }

      // Update total amount
      final newTotalAmount = cartItems.fold(
        0.0,
        (total, item) => total + item.totalPrice,
      );
      totalAmount(newTotalAmount);

      // Save total amount to local storage
      box.write('totalAmount', newTotalAmount);

      // Save cart item to server
      await _cartService.saveCartItem(item as CartModel);
      debugPrint('Cart items from Cart Controller: ${cartItems.length}');
    } catch (e) {
      addingToCartError('Failed to add item to cart');
      debugPrint('Error adding to cart: $e');
    } finally {
      updatingCart(false);
    }
  }

  void decrementQuantity(int index) {
    if (cartItems[index].quantity >= 1) {
      cartItems[index].quantity--;
      updateTotalAmount();
    } else {
      // removeCartItem(index);
      removeItemFromCart(cartItems[index].id);
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

  Future<bool> removeItemFromCart(int itemId) async {
    try {
      final bool success = await _cartService.removeItemFromCart(itemId);
      if (success) {
        // Update cart items list
        update();
      }
      return success;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to remove item from cart: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      debugPrint('Error removing item from cart: $e');
      return false;
    }
  }
}
