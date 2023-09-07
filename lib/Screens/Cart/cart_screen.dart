import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import '../../AppState.dart';
import '../Menu/components/restaurant_infos.dart';
import 'components/cart_products.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  Future<void> refreshScreen(BuildContext context) async {
    await getAllTaskCart();

    final appState = Provider.of<AppStateCart>(context, listen: false);
    appState.updateShowTasksCart(1, products.length);

    setState(() {

    });
  }

  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    refreshScreen(context);
  }

  final String establishmentName = "Food Service";
  final String establishmentAddress = "Rua do Inatel, nº 1000";
  final String establishmentTel = "(35) 9 0000-0000";
  final String establishmentQueueTime = "30~40min. de espera";
  late String clientName;

  int stateTasks = 0;
  int childCountLen2 = 0;

  List<TaskCart> products = [];

  Future<void> getAllTaskCart() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("cart").get();

      products = [];

      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> dados = docSnapshot.data() as Map<String, dynamic>;

        if(dados['userEmail'] == auth.currentUser?.email){
          clientName = dados['userName'];
          String? clientEmail = dados['userEmail'];
          String id = docSnapshot.id;
          String name = dados['name'];
          String ingredients = dados['ingredients'];
          //double preco = docSnapshot['preco'];
          String picture = dados['picture'];
          String quantity = '1';

          TaskCart taskCart = TaskCart(id, name, ingredients, "19,9", picture, quantity);

          products.add(taskCart);
        }
      }
    } catch (e) {
      print('Erro ao obter documentos: $e');
    }
  }

  Future<void> PedidoFinalizado(List<TaskCart> produtosCarrinho) async {
    DateTime now = DateTime.now();
    FirebaseAuth auth = FirebaseAuth.instance;
    Map<String, dynamic> carrinhoMap = {
      'orderTime': now.toUtc(),
      'client': clientName,
      'userEmail': auth.currentUser?.email,
      'stage': "Aguardando...",
      'products': products.map((product) => product.toMap()).toList(),
    };

    db.collection("orders").add(carrinhoMap);

    for (TaskCart product in produtosCarrinho) {
      await db.collection("cart").doc(product.id).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appStateCartGet = Provider.of<AppStateCart>(context);
    return Scaffold(
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
                      SliverList(
                        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {

                            return Consumer<AppStateCart>(builder: (context, appState, _) {
                              stateTasks = appState.stateTaskCart;
                              return buildTaskCartList(index);
                            });
                          },
                          childCount: Provider.of<AppStateCart>(context).childCountLenCart,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            ElevatedButton(
                                onPressed: () async {
                                  for(int i=0; i<products.length; i++){
                                  products[i].quantity = appStateCartGet.taskQuantities[products[i].id] as String;
                                  }

                                  await PedidoFinalizado(products);
                                  refreshScreen(context);
                                },
                                child: const Text("Finalizar pedido"))
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

  Widget buildTaskCartList(int index) {
    switch (stateTasks) {
      case 1:
      //return taskProdutos_lanches[index];
        return products[index];
        break;

      case 2:
        return products[index];
        break;

      case 3:
        return products[index];
        break;

      default:
        return products[index];
        break;
    }
  }
}