import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskOrder extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  final String id;
  final String ingredients;
  final String name;
  final String price;
  final String quantity;
  final String picture;

  TaskOrder(this.id, this.ingredients, this.name, this.price, this.quantity, this.picture, {Key? key}) : super(key: key);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ingredients': ingredients,
      'name': name,
      'price': price,
      'quantity': quantity,
      'picture': picture
    };
  }

  final item = <String, dynamic>{
  };

  @override
  Widget build(BuildContext context) {
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(child: Text(
                        quantity,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),),
                    ),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(child: Text(
                        "R\$ $price",
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
