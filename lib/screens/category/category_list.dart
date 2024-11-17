import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/products.dart';
import '../../router/routes.dart';
import '../../styles/app_colors.dart';
import '../../utils/custom_scroll_behavior.dart';

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
                    onTap: () => context.push(
                      ScreenRoutes.productsByCategory,
                      extra: {'products': products, 'category': category},
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
                      child: Text(
                        category.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
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
