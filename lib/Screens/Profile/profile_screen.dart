import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:food_service_fetin/Screens/Cart/cart_screen.dart';
import 'package:food_service_fetin/Screens/Welcome/welcome_screen.dart';
import '../Menu/components/restaurant_infos.dart';
import '../Menu/components/products_type.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Menu/menu_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  FirebaseAuth auth = FirebaseAuth.instance;

  final List<Widget> _screens = [
    const MenuScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  signOut() async {
    await auth.signOut();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
            const WelcomeScreen()));
  }
  final String establishmentName = "Food Service";
  final String establishmentAddress = "Rua do Inatel, nº 1000";
  final String establishmentTel = "(35) 9 0000-0000";
  final String establishmentQueueTime = "30~40min. de espera";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: Row(children: [Icon(Icons.abc), Icon(Icons.ac_unit)],),

      body: Container(
        color: const Color.fromRGBO(255, 255, 128, 0.25),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final screenWidth = MediaQuery.of(context).size.width;
              final screenHeight = MediaQuery.of(context).size.height;

              double customSize = screenWidth;

              if (kIsWeb) {
                customSize = screenWidth * 0.5;
              }

              return Center(
                child: SizedBox(
                  width: customSize,
                  height: screenHeight,
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: restaurantInfos(
                          establishmentName: establishmentName,
                          establishmentAddress: establishmentAddress,
                          establishmentTel: establishmentTel,
                          establishmentQueueTime: establishmentQueueTime,
                        ),
                      ),
                      const SliverAppBar(
                        flexibleSpace: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ProductType("assets/images/hamburger_icon.webp",
                                  1, 0),
                            ],
                          ),
                        ),
                        floating: true,
                        pinned: true,
                        snap: false,
                        backgroundColor: Colors.transparent,
                        //flexibleSpace: const FlexibleSpaceBar(),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            ElevatedButton(
                                onPressed: () {
                                  signOut();
                                },
                                child: const Text("LOGOUT"))
                          ],
                        ),
                      )
                      //SliverList(delegate: SliverChildBuilderDelegate((context, index) {return ListTile(title: ,)}))
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}