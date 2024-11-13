import 'package:go_router/go_router.dart';

import 'package:my_shop/models/products.dart';
import 'package:my_shop/router/routes.dart';
import 'package:my_shop/screens/cart/cart_screen.dart';
import 'package:my_shop/screens/category/categories_screen.dart';
import 'package:my_shop/screens/category/products_by_category.dart';
import 'package:my_shop/screens/checkout/checkout.dart';
import 'package:my_shop/screens/detail/detail.dart';
import 'package:my_shop/screens/home/home.dart';
import 'package:my_shop/screens/store/catalog.dart';

import '../main.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: ScreenRoutes.main,
    routes: [
      GoRoute(
        path: ScreenRoutes.main,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: ScreenRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: ScreenRoutes.store,
        builder: (context, state) => const CatalogScreen(),
      ),
      GoRoute(
        path: ScreenRoutes.allCategories,
        builder: (context, state) => const CategoriesScreen(),
      ),
      GoRoute(
        path: ScreenRoutes.checkout,
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: ScreenRoutes.cart,
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: ScreenRoutes.detail,
        builder: (context, state) {
          final product = state.extra as Products;
          return DetailScreen(product: product);
        },
      ),
      GoRoute(
        path: ScreenRoutes.productsByCategory,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final products = extra['products'] as List<Products>;
          final category = extra['category'] as Category;

          return ProductsByCategoryWidget(
            products: products,
            category: category,
          );
        },
      ),
    ],
  );
}
