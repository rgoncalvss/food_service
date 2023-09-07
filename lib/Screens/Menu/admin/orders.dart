import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../constants.dart';

void main() {
  runApp(MaterialApp(home: OrderScreen()));
}

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Stream<QuerySnapshot> _pedidosStream;
  late List<Orders> orders;

  @override
  void initState() {
    super.initState();
    _pedidosStream = FirebaseFirestore.instance.collection("orders").snapshots();
    orders = [];
  }

  Future<void> getAllPedidos() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("orders").get();

      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> pedidoData = docSnapshot.data() as Map<String, dynamic>;
        List<dynamic> items = pedidoData['products'];

        Orders pedidos = Orders(
          cliente: pedidoData['client'],
          itens: items,
        );

        orders.add(pedidos);
      }
    } catch (e) {
      print('Erro ao obter pedidos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: FutureBuilder(
        future: getAllPedidos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar pedidos.'));
          }

          if (orders.isEmpty) {
            return const Center(child: Text('Nenhum pedido disponível.'));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    'Cliente: ${orders[index].cliente}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrdersDetail(orders[index]),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class OrdersDetail extends StatelessWidget {
  final Orders orders;

  OrdersDetail(this.orders);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: ListView.builder(
        itemCount: orders.itens.length,
        itemBuilder: (context, index) {
          var item = orders.itens[index];
          return ListTile(
            title: Text(item['name']),
            subtitle: Text('Quantidade: ${item['quantity']}'),
          );
        },
      ),
    );
  }
}

class Orders {
  final String cliente;
  final List<dynamic> itens;

  Orders({required this.cliente, required this.itens});
}
