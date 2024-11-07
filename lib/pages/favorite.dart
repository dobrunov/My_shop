import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../river_providers/product_provider.dart';
import 'detail/detail.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final product = favorites[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(product: product),
                ),
              );
            },
            child: ListTile(
              leading: Image.network(product.image),
              title: Text(product.title),
              subtitle: Text('\$${product.price}'),
              trailing: IconButton(
                icon: const Icon(Icons.remove_circle),
                onPressed: () {
                  ref.read(favoritesProvider.notifier).toggleFavorite(product);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
