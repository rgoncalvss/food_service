import 'package:flutter/material.dart';

import '../../components/products.dart';
import '../../components/products_type.dart';


class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final String nomeEstabelecimento = "Food Service";
  final String enderecoEstabelecimento = "Rua do Inatel, nº 1000";
  final String telefoneEstabelecimento = "(35) 9 0000-0000";
  final String tempoEstabelecimento = "30~40min. de espera";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text("Fetin"),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
            child: Stack(
              fit: StackFit.loose,
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.darken),
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
                    Container(
                      height: 150,
                      width: 150,
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/logo.png",
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
          const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TaskTipoProduto(),
                  TaskTipoProduto(),
                  TaskTipoProduto(),
                  TaskTipoProduto(),
                  TaskTipoProduto(),
                ],
              ),
              Column(
                children: [
                  Produtos(),
                ],
              )
            ],
          ),
          const SizedBox(height: 80)
        ],
      ),
    );
  }
}
