import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:food_service_fetin/Screens/Menu/admin/admin.dart';
import 'package:food_service_fetin/Screens/Menu/admin/orders.dart';

import '../../Profile/profile_screen.dart';


class AdminNavigationMenu extends StatefulWidget {
  const AdminNavigationMenu({Key? key}) : super(key: key);

  @override
  State<AdminNavigationMenu> createState() => _AdminNavigationMenuState();
}

class _AdminNavigationMenuState extends State<AdminNavigationMenu> {
  int _currentIndex = 0;

  final List<Widget> _screens = [const AdminScreen(), const AdminScreen()];

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
      body: Container(
        child: Center(
          child: _buildScreen(_currentIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted), label: "Cardápio"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: "Vendas"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil")
        ],
        backgroundColor: const Color.fromRGBO(255, 255, 128, 1),
      ),
    );
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return AdminScreen();
      case 1:
        return OrderScreen();
      case 2:
        return ProfileScreen();
      default:
        return AdminScreen();
    }
  }
}
