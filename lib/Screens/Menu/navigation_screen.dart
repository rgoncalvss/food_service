
import 'package:flutter/material.dart';
import 'package:food_service_fetin/Screens/Cart/cart_screen.dart';
import 'package:food_service_fetin/Screens/Menu/components/order_screen.dart';
import '../Profile/profile_screen.dart';
import 'menu_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const MenuScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildScreen(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: const Color.fromRGBO(255, 255, 128, 1),
        items: const<BottomNavigationBarItem> [
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted), label: "Cardápio"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Carrinho"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_dining), label: "Pedido"),
          //BottomNavigationBarItem(
              //icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return const MenuScreen();
      case 1:
        return const CartScreen();
      case 2:
        return const OrderScreen();
      //case 3:
        //return ProfileScreen();
      default:
        return Container();
    }
  }
}