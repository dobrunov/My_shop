import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shop/providers/favorites_provider.dart';
import 'package:my_shop/providers/product_provider.dart';
import 'package:my_shop/providers/cart_provider.dart';

import 'core/routes/app_router.dart';
import 'core/theme/styles/app_colors.dart';
import 'features/cart/cart_screen.dart';
import 'features/favorite/favorite.dart';
import 'features/home/home.dart';


void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    FavoritesScreen(),
    CartScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoritesProvider);
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor,
                AppColors.secondaryColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => _onItemTapped(0),
                child: Stack(children: [
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      size: 30.0,
                      Icons.home,
                      color: _selectedIndex == 0 ? Colors.white : AppColors.inactiveColor,
                    ),
                  ),
                ]),
              ),
              GestureDetector(
                onTap: () => _onItemTapped(1),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        size: 30.0,
                        Icons.favorite,
                        color: _selectedIndex == 1 ? Colors.white : AppColors.inactiveColor,
                      ),
                    ),
                    if (favorites.isNotEmpty)
                      Positioned(
                        left: 30,
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: AppColors.badgeColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(minWidth: 15, minHeight: 15),
                          child: Text(
                            '${favorites.length}',
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _onItemTapped(2),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        size: 30.0,
                        Icons.shopping_cart,
                        color: _selectedIndex == 2 ? Colors.white : AppColors.inactiveColor,
                      ),
                    ),
                    if (cartItems.isNotEmpty)
                      Positioned(
                        left: 30,
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: AppColors.badgeColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                          child: Text(
                            '${cartItems.length}',
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
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
