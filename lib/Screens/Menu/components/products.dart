import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  final String name;
  final String ingredients;
  final String price;
  final String picture;
  final String type;


  Product(this.name, this.ingredients, this.price, this.picture, this.type, {Key? key}) : super(key: key);

  final item = <String, dynamic>{
  };

  Map<String, String?> checarUsuarioAtual(){
    User? currentUser = auth.currentUser;
    String? userName = currentUser?.displayName;
    String? userEmail = currentUser?.email;

    print(userName);
    print(userEmail);
    return {
      "userName": userName,
      "userEmail": userEmail,
    };
  }
  void adicionarItens(String? userName, String? userEmail) {
    item['userName'] = userName;
    item['userEmail'] = userEmail;
    item["name"] = name;
    item["ingredients"] = ingredients;
    item["price"] = price;
    item["picture"] = picture;
  }

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
                  child: ClipOval(
                      child: Image.asset(picture)),
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
                                fontSize: 14,
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
                          Map<String, String?> dadosUsuario = checarUsuarioAtual();
                          adicionarItens(dadosUsuario['userName'], dadosUsuario['userEmail']);
                          db.collection("cart").add(item);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.shopping_cart),
                            Text(price),
                          ],
                        )),
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