import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import '../../AppState.dart';
import '../../components/products.dart';
import '../../components/products_type.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

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
  int childCountLen2 = 0;

  List<TaskProduto> taskProdutos_lanches = [
    const TaskProduto(
        "Lanche",
        "Ingredientes: suco, abacate, abacaxi, maca, uva verde, agua, cerveja",
        "RS 49,90",
        "assets/images/hamburger_icon.webp"),
    const TaskProduto("Lanche", "Ingredientes...", "RS 24,90",
        "assets/images/hamburger_icon.webp"),
    const TaskProduto("Lanche", "Ingredientes...", "RS 25,90",
        "assets/images/hamburger_icon.webp"),
    const TaskProduto("Lanche", "Ingredientes...", "RS 26,90",
        "assets/images/hamburger_icon.webp"),
    const TaskProduto("Lanche", "Ingredientes...", "RS 27,90",
        "assets/images/hamburger_icon.webp"),
    const TaskProduto("Lanche", "Ingredientes...", "RS 28,90",
        "assets/images/hamburger_icon.webp"),
    const TaskProduto("Lanche", "Ingredientes...", "RS 29,90",
        "assets/images/hamburger_icon.webp"),
    const TaskProduto("Lanche", "Ingredientes...", "RS 30,90",
        "assets/images/hamburger_icon.webp"),
    const TaskProduto("Lanche", "Ingredientes...", "RS 31,90",
        "assets/images/hamburger_icon.webp"),
    const TaskProduto("Lanche", "Ingredientes...", "RS 32,90",
        "assets/images/hamburger_icon.webp"),
  ];

  List<TaskProduto> taskProdutos_bebidas = [
    const TaskProduto(
        "Bebida", "Ingredientes...", "RS 4,90", "assets/images/drink_icon.png"),
    const TaskProduto(
        "Bebida", "Ingredientes...", "RS 5,90", "assets/images/drink_icon.png"),
    const TaskProduto(
        "Bebida", "Ingredientes...", "RS 6,90", "assets/images/drink_icon.png"),
    const TaskProduto(
        "Bebida", "Ingredientes...", "RS 7,90", "assets/images/drink_icon.png"),
    const TaskProduto(
        "Bebida", "Ingredientes...", "RS 8,90", "assets/images/drink_icon.png"),
    const TaskProduto(
        "Bebida", "Ingredientes...", "RS 9,90", "assets/images/drink_icon.png"),
    const TaskProduto("Bebida", "Ingredientes...", "RS 10,90",
        "assets/images/drink_icon.png"),
    const TaskProduto("Bebida", "Ingredientes...", "RS 11,90",
        "assets/images/drink_icon.png"),
    const TaskProduto("Bebida", "Ingredientes...", "RS 12,90",
        "assets/images/drink_icon.png"),
    const TaskProduto("Bebida", "Ingredientes...", "RS 13,90",
        "assets/images/drink_icon.png"),
  ];

  List<TaskProduto> taskProdutos_doces = [
    const TaskProduto(
        "Doce", "Ingredientes...", "RS 1,90", "assets/images/candy_icon.webp"),
    const TaskProduto(
        "Doce", "Ingredientes...", "RS 2,90", "assets/images/candy_icon.webp"),
    const TaskProduto(
        "Doce", "Ingredientes...", "RS 3,90", "assets/images/candy_icon.webp"),
    const TaskProduto(
        "Doce", "Ingredientes...", "RS 4,90", "assets/images/candy_icon.webp"),
    const TaskProduto(
        "Doce", "Ingredientes...", "RS 5,90", "assets/images/candy_icon.webp"),
    const TaskProduto(
        "Doce", "Ingredientes...", "RS 6,90", "assets/images/candy_icon.webp"),
    const TaskProduto(
        "Doce", "Ingredientes...", "RS 7,90", "assets/images/candy_icon.webp"),
    const TaskProduto(
        "Doce", "Ingredientes...", "RS 8,90", "assets/images/candy_icon.webp"),
    const TaskProduto(
        "Doce", "Ingredientes...", "RS 9,90", "assets/images/candy_icon.webp"),
    const TaskProduto(
        "Doce", "Ingredientes...", "RS 10,90", "assets/images/candy_icon.webp"),
    const TaskProduto(
        "Doce", "Ingredientes...", "RS 11,90", "assets/images/candy_icon.webp"),
  ];

  List<TaskProduto> testeProdutos = [];

  Future<void> getAllTaskProdutos() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("cardapio").get();

      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> dados = docSnapshot.data() as Map<String, dynamic>;

        // Aqui você pode manipular cada documento individualmente
        String nome = docSnapshot['nome'];
        String ingredientes = docSnapshot['ingredientes'];
        String urlFoto = docSnapshot['urlFoto'];
        // ... outros atributos

        TaskProduto taskProduto =
        TaskProduto(nome, ingredientes, "RS 19,90", urlFoto);

        testeProdutos.add(taskProduto);
      }
    } catch (e) {
      // Trate qualquer erro ocorrido durante a obtenção dos documentos
      print('Erro ao obter documentos: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: Row(children: [Icon(Icons.abc), Icon(Icons.ac_unit)],),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted), label: "Cardápio"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Carrinho"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil")
        ],
        backgroundColor: const Color.fromRGBO(255, 255, 128, 1),
      ),
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4)),
                            child: Stack(
                              fit: StackFit.loose,
                              alignment: AlignmentDirectional.center,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.6),
                                          BlendMode.darken),
                                      child: Opacity(
                                        opacity: 0.7,
                                        child: Image.asset(
                                          "assets/images/hamburger.jpg",
                                          fit: BoxFit.cover,
                                          height: 300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: ClipOval(
                                        child: Image.asset(
                                          "assets/images/logo.jpeg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      nomeEstabelecimento,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      enderecoEstabelecimento,
                                      style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      telefoneEstabelecimento,
                                      style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      tempoEstabelecimento,
                                      style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverAppBar(
                        flexibleSpace: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TaskTipoProduto("assets/images/hamburger_icon.webp",
                                  1, testeProdutos.length),
                              TaskTipoProduto("assets/images/drink_icon.png", 2,
                                  taskProdutos_bebidas.length),
                              TaskTipoProduto("assets/images/candy_icon.webp", 3,
                                  taskProdutos_doces.length),
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
                                  childCountLen2 = appState.childCountLen;
                                  print("quantidade: $childCountLen2");
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
                                          const MenuScreen()));
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
        return testeProdutos[index];
        break;

      case 2:
        return taskProdutos_bebidas[index];
        break;

      case 3:
        return taskProdutos_doces[index];
        break;

      default:
        return taskProdutos_lanches[index];
        break;
    }
  }
}