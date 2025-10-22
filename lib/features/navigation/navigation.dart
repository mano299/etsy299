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
    Center(child: Text("Shop", style: TextStyle(color: Colors.white))),
    Center(child: Text("Deals", style: TextStyle(color: Colors.white))),
    Center(child: Text("Favourites", style: TextStyle(color: Colors.white))),
    Center(child: Text("Basket", style: TextStyle(color: Colors.white))),
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
              icon: Icon(FontAwesomeIcons.magnifyingGlass), label: "Shop"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.heart), label: "Favourites"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.cartShopping), label: "Cart"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidUser), label: "Profile"),
        ],
      ),
    );
  }
}
