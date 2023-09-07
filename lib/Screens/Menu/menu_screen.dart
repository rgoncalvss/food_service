import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:food_service_fetin/Screens/Cart/cart_screen.dart';
import 'package:provider/provider.dart';
import '../../AppState.dart';
import 'components/products.dart';
import 'components/products_type.dart';
import 'components/restaurant_infos.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  final List<Widget> _screens = [
    const MenuScreen(),
    const CartScreen(),
    const MenuScreen(),
  ];

  @override
  void initState() {
    super.initState();
    refreshScreen(context);
  }

  final String establishmentName = "Food Service";
  final String establishmentAddress = "Rua do Inatel, nº 1000";
  final String establishmentTel = "(35) 9 0000-0000";
  final String establishmentQueueTime = "30~40min. de espera";

  int stateTasks = 0;

  List<Product> snacks = [];
  List<Product> drinks = [];
  List<Product> candies = [];

  Future<void> refreshScreen(BuildContext context) async {
    await getAllTaskProdutos();

    final appState = Provider.of<AppState>(context, listen: false);
    appState.updateShowTasks(1, snacks.length);

    setState(() {
    });
  }

  Future<void> getAllTaskProdutos() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("menu").get();

      snacks = [];
      drinks = [];
      candies = [];

      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> product = docSnapshot.data() as Map<String, dynamic>;

        String name = product['name'];
        String ingredients = product['ingredients'];
        String price = product['price'];
        String picture = product['picture'];
        String type = product['type'];

        Product taskProduto =
        Product(name, ingredients, price, picture, type);

        switch(taskProduto.type){
          case "Snack":
            snacks.add(taskProduto);
            break;
          case "Drink":
            drinks.add(taskProduto);
            break;
          case "Candy":
            candies.add(taskProduto);
            break;
          default:
            break;
        }
      }
    } catch (e) {
      print('Erro ao obter documentos: $e');
    }
  }


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
                      SliverAppBar(
                        flexibleSpace: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ProductType("assets/images/hamburger_icon.webp",
                                  1, snacks.length),
                              ProductType("assets/images/drink_icon.png",
                                  2, drinks.length),
                              ProductType("assets/images/candy_icon.webp",
                                  3, candies.length),
                            ],
                          ),
                        ),
                        floating: true,
                        pinned: true,
                        snap: false,
                        backgroundColor: Colors.transparent,
                        //flexibleSpace: const FlexibleSpaceBar(),
                      ),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return Consumer<AppState>(builder: (context, appState, _) {
                                  stateTasks = appState.stateTaskProduto;
                                  return buildTaskProdutosList(index);
                                });
                              }, childCount: Provider.of<AppState>(context).childCountLen)),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget buildTaskProdutosList(int index) {
    switch (stateTasks) {
      case 1:
      //return taskProdutos_lanches[index];
        return snacks[index];
        break;

      case 2:
        return drinks[index];
        break;

      case 3:
        return candies[index];
        break;

      default:
        return snacks[index];
        break;
    }
  }
}