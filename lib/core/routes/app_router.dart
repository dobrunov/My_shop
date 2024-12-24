import 'package:go_router/go_router.dart';

import 'package:my_shop/core/routes/routes.dart';
import 'package:my_shop/models/products.dart';
import '../../features/cart/cart_screen.dart';
import '../../features/category/categories_screen.dart';
import '../../features/category/widgets/products_by_category.dart';
import '../../features/checkout/checkout.dart';
import '../../features/detail/detail.dart';
import '../../features/home/home.dart';
import '../../features/store/catalog.dart';
import '../../main.dart';


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
