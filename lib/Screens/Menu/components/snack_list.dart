import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import '../../../AppState.dart';
import 'products.dart';

class SnackList extends StatefulWidget {
  const SnackList({Key? key}) : super(key: key);

  @override
  State<SnackList> createState() => _SnackListState();
}

class _SnackListState extends State<SnackList> {
  
  @override
  void initState() {
    super.initState();
    getAllTaskProdutos();
  }

  final String nomeEstabelecimento = "Food Service";
  final String enderecoEstabelecimento = "Rua do Inatel, nº 1000";
  final String telefoneEstabelecimento = "(35) 9 0000-0000";
  final String tempoEstabelecimento = "30~40min. de espera";

  int stateTasks = 0;

  List<Product> snacks = [];

  Future<void> getAllTaskProdutos() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("menu").get();

      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> dados = docSnapshot.data() as Map<String, dynamic>;

        String name = docSnapshot['name'];
        String ingredients = docSnapshot['ingredients'];
        //double preco = docSnapshot['preco'];
        String picture = docSnapshot['picture'];
        String type = docSnapshot['type'];

        Product taskProduto = Product(name, ingredients, "19,9", picture, type);

        snacks.add(taskProduto);
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
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return Consumer<AppState>(builder: (context, appState, _) {
                                  stateTasks = appState.stateTaskProduto;
                                  return buildTaskProdutosList(index);
                                });
                              }, childCount: Provider.of<AppState>(context).childCountLen)),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const SnackList()));
                                },
                                child: const Text("Mudar tela"))
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

  Widget buildTaskProdutosList(int index) {
    switch (stateTasks) {
      case 1:
      //return taskProdutos_lanches[index];
        return snacks[index];
        break;

      case 2:
        return snacks[index];
        break;

      case 3:
        return snacks[index];
        break;

      default:
        return snacks[index];
        break;
    }
  }
}