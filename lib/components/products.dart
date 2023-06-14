import 'package:flutter/material.dart';

class TaskProduto extends StatelessWidget {
  final String nomeProduto;
  final String ingredientesProduto;
  final String precoProduto;
  final String urlImage;

  const TaskProduto(this.nomeProduto, this.ingredientesProduto, this.precoProduto, this.urlImage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          color: const Color.fromRGBO(255, 133, 102, 1), // 255,153,128
          height: 100,
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(4)),
                    height: 100,
                    alignment: AlignmentDirectional.centerStart,
                    child: ClipOval(
                        child: Image.asset(urlImage)),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(nomeProduto,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                overflow: TextOverflow.ellipsis)),
                        Expanded(
                          child: Text(ingredientesProduto,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  overflow: TextOverflow.visible)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: 91,
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(Icons.shopping_cart),
                              Text(precoProduto)
                            ],
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}