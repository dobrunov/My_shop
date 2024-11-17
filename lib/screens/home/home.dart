import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/products.dart';
import '../../providers/product_provider.dart';
import '../../router/routes.dart';
import '../../styles/app_colors.dart';
import '../../utils/custom_scroll_behavior.dart';
import '../category/category_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsyncValue = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My shop'),
      ),
      body: Column(
        children: [
          productsAsyncValue.when(
            data: (products) {
              Products mostExpProduct = findMostExpensiveProduct(products);

              return Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.secondaryColor,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 120,
                            child: Center(
                                child: Text(
                              mostExpProduct.title,
                              style: TextStyle(color: AppColors.bannerTextColor, fontWeight: FontWeight.bold),
                            ))),
                        Image.network(
                          mostExpProduct.image,
                          width: 160,
                          height: 120,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  child: Text(
                    'View All Categories',
                    style: TextStyle(fontSize: 15, color: AppColors.pricesTextColor, fontWeight: FontWeight.bold),
                  ),
                  onTap: () => context.push(ScreenRoutes.allCategories),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          productsAsyncValue.when(
              data: (products) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  child: CategoryListWidget(products: products),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error'))),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Most popular',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  child: Text(
                    'View All',
                    style: TextStyle(fontSize: 15, color: AppColors.pricesTextColor, fontWeight: FontWeight.bold),
                  ),
                  onTap: () => context.push(ScreenRoutes.store),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          productsAsyncValue.when(
            data: (products) {
              return Expanded(
                child: ScrollConfiguration(
                  behavior: MyCustomScrollBehavior(),
                  child: GridView.builder(
                    padding: const EdgeInsets.only(left: 12.0, top: 2, right: 12, bottom: 12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2 / 3,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Consumer(
                        builder: (context, ref, _) {
                          final favorites = ref.watch(favoritesProvider);
                          final isFavorite = favorites.contains(product);
                          return GestureDetector(
                            onTap: () => context.push(ScreenRoutes.detail, extra: product),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.cardBackgroundColor,
                                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.category.name,
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                          GestureDetector(
                                            child: Icon(
                                              Icons.favorite,
                                              color: isFavorite ? AppColors.badgeColor : AppColors.badgeInactiveColor,
                                            ),
                                            onTap: () {
                                              ref.read(favoritesProvider.notifier).toggleFavorite(product);
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    Image.network(
                                      product.image,
                                      width: 80,
                                      height: 120,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.title.substring(0, 12),
                                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '\$${product.price}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.pricesTextColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
        ],
      ),
    );
  }

  Products findMostExpensiveProduct(List<Products> products) {
    if (products.isEmpty) {
      throw Exception('The products list is empty');
    }
    return products.reduce((curr, next) => curr.price > next.price ? curr : next);
  }
}
