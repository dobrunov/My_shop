import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/routes/routes.dart';
import '../../core/theme/styles/app_colors.dart';
import '../../core/utils/custom_scroll_behavior.dart';
import '../../providers/favorites_provider.dart';


class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (favorites.isNotEmpty)
            Expanded(
              child: ScrollConfiguration(
                behavior: MyCustomScrollBehavior(),
                child: ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final product = favorites[index];
                    return GestureDetector(
                      onTap: () => context.push(ScreenRoutes.detail, extra: product),
                      child: ListTile(
                        leading: Image.network(product.image),
                        title: Text(product.title),
                        subtitle: Text(
                          '\$${product.price}',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.pricesTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Color(0xfffb2149),
                          ),
                          onPressed: () {
                            ref.read(favoritesProvider.notifier).toggleFavorite(product);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          if (favorites.isEmpty)
            const Center(
                child: Text(
              'You have not selected the products you like',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        ],
      ),
    );
  }
}
