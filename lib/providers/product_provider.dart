import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

import '../models/products.dart';

const shopUrlPico = 'http://192.168.13.120:80';
const shopUrlEsp32 = 'http://192.168.13.151/products';
const shopUrlWeb = 'https://fakestoreapi.com/products';

final productsProvider = FutureProvider<List<Products>>((ref) async {
  final response = await http.get(Uri.parse(shopUrlWeb));
  final products = productsFromJson(response.body);
  log("$products");
  return products;
});

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
