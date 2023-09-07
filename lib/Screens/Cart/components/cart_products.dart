import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:provider/provider.dart';

import '../../../AppState.dart';

class TaskCart extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  final String id;
  final String name;
  final String ingredients;
  final String price;
  final String picture;
  String quantity;

  TaskCart(this.id, this.name, this.ingredients, this.price, this.picture, this.quantity, {Key? key}) : super(key: key);

  //final stateCart = Provider.of<AppStateCart>(context);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'price': price,
      'picture': picture,
      'quantity': quantity
    };
  }

  final item = <String, dynamic>{
  };

  void adicionarItens() {
    item["name"] = name;
    item["ingredients"] = ingredients;
    item["price"] = price;
    item["picture"] = picture;
    item["quantity"] = '1';
  }

  void deleteItem(String itemId) async {
    DocumentReference docRef =
    FirebaseFirestore.instance.collection('cart').doc(itemId);

    await docRef.delete();
  }

  @override
  Widget build(BuildContext context) {
    final appStateCart = Provider.of<AppStateCart>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          color: const Color.fromRGBO(255, 133, 102, 1), // 255,153,128
          height: 100,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
                      height: 100,
                      alignment: AlignmentDirectional.centerStart,
                      child: ClipOval(child: Image.asset(picture)),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              ingredients,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: const Color.fromRGBO(255, 133, 102, 1),
                      child: InputQty(
                        boxDecoration: BoxDecoration(
                          color: Color.fromRGBO(255, 133, 102, 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        btnColor1: Colors.black,
                        btnColor2: Colors.black, // Cor dos ícones de aumento e diminuição
                        minVal: 1,
                        maxVal: 10, // Valor máximo permitido
                        initVal: 1, // Valor inicial mínimo
                        onQtyChanged: (val) {
                          String qtd = val.toString();
                          appStateCart.updateQuantities(id,  qtd);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -8,
                right: -8,
                child: IconButton(
                  iconSize: 25,
                  icon: Icon(Icons.close),
                  color: Colors.black,
                  onPressed: () {
                    deleteItem(id);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
