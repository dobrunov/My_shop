import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_shop/river_providers/product_provider.dart';
import 'package:my_shop/river_providers/providers.dart';
import '../../utils/custom_scroll_behavior.dart';
import '../cart/cart.dart';
import '../detail/detail.dart';

class CatalogScreen extends ConsumerStatefulWidget {
  const CatalogScreen({super.key});

  @override
  StoreScreenState createState() => StoreScreenState();
}

class StoreScreenState extends ConsumerState<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final productsAsyncValue = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
      ),
      body: productsAsyncValue.when(
        data: (products) {
          return ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: Image.network(
                    product.image,
                    width: 40,
                  ),
                  title: Text(
                    product.title.substring(0, 18),
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('\$${product.price}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(product: product),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
