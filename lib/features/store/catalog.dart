import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/routes/routes.dart';
import '../../core/utils/custom_scroll_behavior.dart';
import '../../providers/product_provider.dart';


class CatalogScreen extends ConsumerStatefulWidget {
  const CatalogScreen({super.key});

  @override
  StoreScreenState createState() => StoreScreenState();
}

class StoreScreenState extends ConsumerState<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
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
                  onTap: () => context.push(ScreenRoutes.detail, extra: product),
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
