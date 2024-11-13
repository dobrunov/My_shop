import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/products.dart';
import '../../router/routes.dart';

class ProductsByCategoryWidget extends StatelessWidget {
  final List<Products> products;
  final Category category;

  const ProductsByCategoryWidget({super.key, required this.products, required this.category});

  @override
  Widget build(BuildContext context) {
    List<Products> filteredProducts = filterProductsByCategory(products, category);

    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: ListView.builder(
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final product = filteredProducts[index];
          return ListTile(
            leading: Image.network(
              product.image,
              width: 40,
            ),
            title: Text(
              product.title.substring(0, 12),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            onTap: () => context.push(ScreenRoutes.detail, extra: product),
          );
        },
      ),
    );
  }

  List<Products> filterProductsByCategory(List<Products> products, Category category) {
    return products.where((product) => product.category == category).toList();
  }
}
