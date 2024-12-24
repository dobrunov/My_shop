import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/products.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<Products>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<Products>> {
  CartNotifier() : super([]);

  void addProduct(Products product) {
    state = [
      for (final existingProduct in state)
        if (existingProduct.title == product.title)
          existingProduct.copyWith(quantity: existingProduct.quantity + product.quantity)
        else
          existingProduct,
      if (!state.any((existingProduct) => existingProduct.title == product.title)) product,
    ];
  }

  void updateQuantity(Products product, int quantity) {
    state = [
      for (final existingProduct in state)
        if (existingProduct.title == product.title) existingProduct.copyWith(quantity: quantity) else existingProduct,
    ];
  }

  void removeProduct(Products product) {
    state = state.where((existingProduct) => existingProduct.title != product.title).toList();
  }
}
