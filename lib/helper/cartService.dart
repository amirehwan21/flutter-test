import 'dart:convert';

import 'package:myeg_flutter_test/model/productModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {

  static const _cartKey = 'user_cart';

  static Future<void> addToCart(ProductModel product) async {
    final prefs = await SharedPreferences.getInstance();
    final cart = await getCart();

    final existingIndex = cart.indexWhere((p) => p.id == product.id);

    if (existingIndex >= 0) {
      cart[existingIndex].quantity += product.quantity;
    } else {
      cart.add(product);
    }
    await _saveCart(cart);
  }

  static Future<void> removeFromCart(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final cart = await getCart();
    cart.removeWhere((p) => p.id == productId);
    await _saveCart(cart);
  }

  // Get all cart items
  static Future<List<ProductModel>> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getStringList(_cartKey) ?? [];
    return cartJson.map((json) => ProductModel.fromJson(jsonDecode(json))).toList();
  }

   // Helper method to save cart
  static Future<void> _saveCart(List<ProductModel> cart) async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = cart.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList(_cartKey, cartJson);
  }

  // update quantity cart items
  static Future<void> updateQuantity(int productId, int newQuantity) async {
    final prefs = await SharedPreferences.getInstance();
    final cart = await getCart();
    final index = cart.indexWhere((p) => p.id == productId);
    
    if (index >= 0) {
      if (newQuantity <= 0) {
        cart.removeAt(index);
      } else {
        cart[index].quantity = newQuantity;
      }
      await _saveCart(cart);
    }
  }
}