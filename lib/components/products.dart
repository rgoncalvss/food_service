import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  final String name;
  final String ingredients;
  final String price;
  final String picture;

  const Product(this.name, this.ingredients, this.price, this.picture, {Key? key}) : super(key: key);

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
                            Text(price)
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