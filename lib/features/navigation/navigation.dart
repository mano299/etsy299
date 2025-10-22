import 'package:etsy/features/Search/views_products/all_products_search_screens.dart';
import 'package:etsy/features/card/screens/cart_screen.dart';
import 'package:etsy/features/favorite/view/screen/fav_home_screen.dart';
import 'package:etsy/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:etsy/features/home/presentation/views/home_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentIndex = 0;

  List<Widget> views = const [
    HomePage(),
    AllProductsSearchScreens(),
    FavHomeScreen(),
    CartScreen(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: views[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.magnifyingGlass), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidHeart), label: "Favourites"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.cartShopping), label: "Cart"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidUser), label: "Profile"),
        ],
      ),
    );
  }
}
