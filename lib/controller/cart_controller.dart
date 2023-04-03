import 'package:fashion_app/model/cart.dart';
import 'package:fashion_app/services/cart.dart';
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
      updateTotalAmount();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch cart items: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> addItemToCart(String cartId, CartModel cartItem) async {
    try {
      final addedItem = await _cartService.addItemToCart(cartId, cartItem);
      cartItems.add(addedItem);
      Get.snackbar(
        'Item added to cart',
        'Your item has been added to the cart.',
      );
      updateTotalAmount();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add item to cart: $e');
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
      0,
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
