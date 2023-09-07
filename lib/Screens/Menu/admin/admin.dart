import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:food_service_fetin/Screens/Menu/admin/add_products.dart';
import 'package:food_service_fetin/Screens/Menu/admin/orders.dart';
import 'package:provider/provider.dart';
import '../../../AppState.dart';
import '../components/restaurant_infos.dart';
import '../components/products_type.dart';
import 'components/products_admin.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot<Map<String, dynamic>>> documentStream;

  void handleTaskCallback() {
    refreshScreen(context);
  }

  final List<Widget> _screens = [
    AdminScreen(),
    OrderScreen(),
    AdminScreen(),
  ];

  @override
  void initState() {
    super.initState();
    refreshScreen(context);

    documentStream = firestore.collection('menu').snapshots();

    documentStream.listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      if(mounted) {
        refreshScreen(context);
      }
    });
  }

  final String establishmentName = "Food Service";
  final String establishmentAddress = "Rua do Inatel, nº 1000";
  final String establishmentTel = "(35) 9 0000-0000";
  final String establishmentQueueTime = "30~40min. de espera";

  int stateTasks = 0;

  List<AdminProduct> snacks = [];
  List<AdminProduct> drinks = [];
  List<AdminProduct> candies = [];

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
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

        String name = data['name'];
        String ingredients = data['ingredients'];
        String price = data['price'] as String;
        String picture = data['picture'];
        String id = docSnapshot.id;
        String type = data['type'];

        AdminProduct productItem =
        AdminProduct(name, ingredients, price, picture, id, type, onTapCallback: handleTaskCallback);

        switch(productItem.type){
          case "Snack":
            snacks.add(productItem);
            break;
          case "Drink":
            drinks.add(productItem);
            break;
          case "Candy":
            candies.add(productItem);
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
      body: Container(
        color: const Color.fromRGBO(255, 255, 128, 0.25),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final screenWidth = MediaQuery
                  .of(context)
                  .size
                  .width;
              final screenHeight = MediaQuery
                  .of(context)
                  .size
                  .height;

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
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QuestionScreen()),
                                  );
                                },
                                child: SizedBox(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: const Row(
                                      children: [
                                        Icon(Icons.add),
                                        Text("Adicionar produto")
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ),
                      SliverAppBar(
                        flexibleSpace: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ProductType(
                                  "assets/images/hamburger_icon.webp", 1,
                                  snacks.length),
                              ProductType(
                                  "assets/images/drink_icon.png", 2,
                                  drinks.length),
                              ProductType(
                                  "assets/images/candy_icon.webp", 3,
                                  candies.length),
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
                                return Consumer<AppState>(
                                    builder: (context, appState, _) {
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
      case 0:
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