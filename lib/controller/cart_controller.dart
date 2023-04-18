import 'package:fashion_app/model/cart.dart';
import 'package:fashion_app/model/products.dart';
import 'package:fashion_app/services/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {
  final CartService _cartService = CartService();

  final RxList<CartModel> cartItems = RxList<CartModel>([]);
  final RxBool isLoading = true.obs;

  final RxDouble totalAmount = 0.0.obs;
  final box = GetStorage();

  int lastCartId = 0;

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
        final newCartItem = CartModel(
          productId: item.id,
          quantity: 1,
          price: item.price,
          totalPrice: double.tryParse(item.price.toString()) ?? 0.0,
          name: item.name,
          // id: int.tryParse(Uuid().v1()) ?? 0,
          id: lastCartId++,
          userId: item.id,
        );
        cartItems.add(newCartItem);
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
      await _cartService.saveCartItem(cartItems.last);
      debugPrint('Cart items from Cart Controller: ${cartItems.length}');
    } catch (e) {
      addingToCartError('Failed to add item to cart $e');
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
      final bool success =
          await _cartService.removeCartItem(int.parse(itemId.toString()));
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

  // void updateCartItemQuantity(int index, int newQuantity) {
  //   final CartModel updatedItem =
  //       cartItems[index].copyWith(quantity: newQuantity);
  //   cartItems[index] = updatedItem;
  //   updateTotalAmount();
  // }

  void updateCartItemQuantity(int index, int newQuantity) async {
    try {
      final CartModel updatedItem =
          cartItems[index].copyWith(quantity: newQuantity);

      // Update cart item on the server
      await _cartService.updateCartItem(updatedItem);

      // Update local cart state
      cartItems[index] = updatedItem;
      updateTotalAmount();

      // Update cart item quantity on the server
      int itemId = int.tryParse(updatedItem.id as String) ?? -1;
      await _cartService.updateCartItemQuantity(itemId, newQuantity);

      // Show success message
      Get.snackbar(
        'Success',
        'Cart item quantity updated',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update cart item quantity: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      debugPrint('Error updating cart item quantity: $e');
    }
  }
}
