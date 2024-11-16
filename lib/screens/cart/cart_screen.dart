import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/providers.dart';
import '../../router/routes.dart';
import '../../styles/app_colors.dart';
import '../../utils/custom_scroll_behavior.dart';
import 'cart_tile.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final totalPrice = cartItems.fold<double>(0.0, (sum, item) => sum + (item.price * item.quantity));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (cartItems.isNotEmpty)
            Expanded(
              child: ScrollConfiguration(
                behavior: MyCustomScrollBehavior(),
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return CartTile(index: index);
                  },
                ),
              ),
            ),
          if (cartItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total amount:',
                        style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () => context.push(ScreenRoutes.checkout),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.pricesTextColor, foregroundColor: Colors.white),
                      child: const Text('Create order'),
                    ),
                  ),
                ],
              ),
            ),
          if (cartItems.isEmpty)
            const Center(
                child: Text(
              'Your cart is empty',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        ],
      ),
    );
  }
}
