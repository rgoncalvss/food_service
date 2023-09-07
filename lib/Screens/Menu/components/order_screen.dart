import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:food_service_fetin/Screens/Menu/components/order_products.dart';

import 'restaurant_infos.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future<void> refreshScreen(BuildContext context) async {
    await getAllTaskOrder();

    setState(() {});
  }

  final db = FirebaseFirestore.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot<Map<String, dynamic>>> documentStream;

  @override
  void initState() {
    super.initState();
    refreshScreen(context);

    documentStream = firestore.collection('pedidos').snapshots();

    documentStream.listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      if (mounted) {
        refreshScreen(context);
      }
    });
  }

  final String establishmentName = "Food Service";
  final String establishmentAddress = "Rua do Inatel, nº 1000";
  final String establishmentTel = "(35) 9 0000-0000";
  final String establishmentQueueTime = "30~40min. de espera";
  late String clientName;

  List<TaskOrder> order = [];
  String stage = "";
  double total = 0;
  String totalStr = "";

  Future<void> getAllTaskOrder() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("orders").get();

      order = [];
      total = 0;

      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> dados = docSnapshot.data() as Map<String, dynamic>;

        if (dados['userEmail'] == auth.currentUser?.email) {
          stage = dados["stage"];

          for (int i = 0; i < dados["products"].length; i++) {
            String id = dados["products"][i]["id"];
            String name = dados["products"][i]["name"];
            String ingredients = dados["products"][i]["ingredients"];
            String price = dados["products"][i]["price"];
            String picture = dados["products"][i]["picture"];
            String quantity = dados["products"][i]["quantity"];

            price = price.contains('.') && price.split('.')[1].length == 1
                ? price + "0"
                : price;

            price = price.contains(',') && price.split(',')[1].length == 1
                ? price + "0"
                : price;

            TaskOrder taskOrder =
                TaskOrder(id, ingredients, name, price, quantity, picture);
            order.add(taskOrder);

            total +=
                double.parse(price.replaceAll(",", ".")) * int.parse(quantity);
          }
          totalStr = total.toStringAsFixed(2);

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
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    ClipOval(
                                        child: Container(
                                            width: 60,
                                            height: 60,
                                            color: stage == "Aguardando..."
                                                ? Colors.blue
                                                : Colors.grey,
                                            child: Icon(
                                                size: 30,
                                                Icons.timer,
                                                color: stage == "Aguardando..."
                                                    ? Color.fromRGBO(
                                                        255, 255, 128, 1)
                                                    : Colors.white))),
                                    Text(
                                      "Aguardando...",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: stage == "Aguardando..."
                                            ? Colors.blue
                                            : Colors.grey,
                                        letterSpacing: 2.0,
                                        fontStyle: FontStyle.normal,
                                        decorationThickness: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    ClipOval(
                                        child: Container(
                                            width: 60,
                                            height: 60,
                                            color: stage == "Visualizado"
                                                ? Colors.blue
                                                : Colors.grey,
                                            child: Icon(
                                                size: 30,
                                                Icons.remove_red_eye,
                                                color: stage == "Visualizado"
                                                    ? Color.fromRGBO(
                                                        255, 255, 128, 1)
                                                    : Colors.white))),
                                    Text(
                                      "Visualizado",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: stage == "Visualizado"
                                            ? Colors.blue
                                            : Colors.grey,
                                        letterSpacing: 2.0,
                                        fontStyle: FontStyle.normal,
                                        decorationThickness: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    ClipOval(
                                        child: Container(
                                            width: 60,
                                            height: 60,
                                            color: stage == "Em preparo"
                                                ? Colors.blue
                                                : Colors.grey,
                                            child: Icon(
                                                size: 30,
                                                Icons.local_dining,
                                                color: stage == "Em preparo"
                                                    ? Color.fromRGBO(
                                                        255, 255, 128, 1)
                                                    : Colors.white))),
                                    Text(
                                      "Em preparo",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: stage == "Em preparo"
                                            ? Colors.blue
                                            : Colors.grey,
                                        letterSpacing: 2.0,
                                        fontStyle: FontStyle.normal,
                                        decorationThickness: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    ClipOval(
                                        child: Container(
                                            width: 60,
                                            height: 60,
                                            color: stage == "Finalizado"
                                                ? Colors.blue
                                                : Colors.grey,
                                            child: Icon(
                                                size: 30,
                                                Icons.done_outline,
                                                color: stage == "Finalizado"
                                                    ? Color.fromRGBO(
                                                        255, 255, 128, 1)
                                                    : Colors.white))),
                                    Text(
                                      "Finalizado",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: stage == "Finalizado"
                                            ? Colors.blue
                                            : Colors.grey,
                                        letterSpacing: 2.0,
                                        fontStyle: FontStyle.normal,
                                        decorationThickness: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return order[index];
                      },
                      childCount: order.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                            width: double.infinity,
                            child: Text(
                              "Total do pedido: R\$ $totalStr",
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                letterSpacing: 2.0,
                                fontStyle: FontStyle.normal,
                                decorationThickness: 2,
                              ),
                            )),
                      ),
                    ),
                  ),
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
