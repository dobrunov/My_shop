import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/products.dart';

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Products>>((ref) => FavoritesNotifier());

class FavoritesNotifier extends StateNotifier<List<Products>> {
  FavoritesNotifier() : super([]);

  void toggleFavorite(Products product) {
    log("like");
    if (state.contains(product)) {
      state = state.where((p) => p.id != product.id).toList();
    } else {
      state = [...state, product];
    }
    product = product.copyWith(isFavorite: !product.isFavorite);
    log(product.isFavorite.toString());
  }
}