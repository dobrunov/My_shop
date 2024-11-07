import 'package:flutter/material.dart';

import '../../models/products.dart';
import '../../utils/custom_scroll_behavior.dart';
import '../category/products_by_category.dart';

class CategoryListWidget extends StatelessWidget {
  final List<Products> products;

  const CategoryListWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    List<Category> categories = getUniqueCategories(products);

    return ScrollConfiguration(
      behavior: MyCustomScrollBehavior(),
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (final category in categories)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsByCategoryWidget(products: products, category: category),
                        ),
                      );
                    },
                    child: Chip(
                      label: Text(
                        category.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.blueGrey[300],
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Category> getUniqueCategories(List<Products> products) {
    return products.map((product) => product.category).toSet().toList();
  }
}
