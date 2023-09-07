import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminProduct extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  final String name;
  final String ingredients;
  final String price;
  final String picture;
  final String id;
  final String type;

  final VoidCallback onTapCallback;

  void deleteItem(String itemId) async {
    DocumentReference docRef =
    FirebaseFirestore.instance.collection('menu').doc(itemId);

    await docRef.delete();
  }

  AdminProduct(this.name, this.ingredients, this.price,
      this.picture, this.id, this.type,
      {Key? key, required this.onTapCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          color: const Color.fromRGBO(255, 133, 102, 1), // 255,153,128
          height: 100,
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
                  child: ClipOval(child: Image.asset(picture)),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              overflow: TextOverflow.ellipsis)),
                      Expanded(
                        child: Text(ingredients,
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
                        onPressed: () {
                          deleteItem(id);
                          onTapCallback;
                        }, child: const Icon(Icons.close),
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
