import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/cart_provider.dart';

class CounterWidget extends ConsumerWidget {
  const CounterWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final product = cartItems[index];
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            if (product.quantity > 1) {
              ref.read(cartProvider.notifier).updateQuantity(product, product.quantity - 1);
            } else {
              null;
            }
          },
        ),
        Text('${product.quantity}'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            ref.read(cartProvider.notifier).updateQuantity(product, product.quantity + 1);
          },
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}
