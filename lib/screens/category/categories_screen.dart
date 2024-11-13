import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/products.dart';
import '../../providers/product_provider.dart';
import '../../providers/providers.dart';
import '../../router/routes.dart';
import '../../utils/custom_scroll_behavior.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final productsAsyncValue = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: productsAsyncValue.when(
        data: (products) {
          List<Category> categories = getUniqueCategories(products);
          return ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[200],
                        borderRadius: const BorderRadius.all(Radius.circular(35.0)),
                      ),
                      child: Center(
                        child: ListTile(
                          title: Text(
                            categories[index].name,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          onTap: () => context.push(
                            ScreenRoutes.productsByCategory,
                            extra: {
                              'products': products,
                              'category': categories[index],
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  List<Category> getUniqueCategories(List<Products> products) {
    return products.map((product) => product.category).toSet().toList();
  }
}
