import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/routes.dart';
import '../../../core/theme/styles/app_colors.dart';
import '../../../providers/cart_provider.dart';
import 'counter.dart';

class CartTile extends ConsumerWidget {
  const CartTile({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final product = cartItems[index];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.cardBackgroundColor,
        ),
        child: GestureDetector(
          onTap: () => context.push(ScreenRoutes.detail, extra: product),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10),
                      child: Text(
                        product.title,
                        style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    CounterWidget(index: index),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete_forever_rounded),
                      onPressed: () {
                        ref.read(cartProvider.notifier).removeProduct(product);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, right: 10),
                      child: Text(
                        '\$${product.price * product.quantity}',
                        style: TextStyle(fontSize: 15, color: AppColors.pricesTextColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
