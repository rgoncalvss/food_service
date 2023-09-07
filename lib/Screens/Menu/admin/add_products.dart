import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _photoUrlController = TextEditingController();

  String _name = '';
  String _ingredients = '';
  String _price = '';
  String _photoUrl = '';
  String _type = 'Lanche';
  String urlAux = 'assets/images/hamburger_icon.webp';

  void addNewItem(String name, String ingredients, String price, String picture,
      String type) async {

    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection('menu');

    await collectionRef.add({
      'name': name,
      'ingredients': ingredients,
      'price': price,
      'picture': picture,
      'type': type
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ingredientsController.dispose();
    _priceController.dispose();
    _photoUrlController.dispose();
    super.dispose();
  }

  void _addProduct() {
    setState(() {
      _name = _nameController.text;
      _ingredients = _ingredientsController.text;
      _price = _priceController.text;
      _photoUrl = urlAux;
      _type = _type;
    });

    addNewItem(_name, _ingredients, _price, _photoUrl, _type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _ingredientsController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ingredientes',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Preço',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _photoUrlController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'URL da Foto',
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            const SizedBox(height: 20),
            RadioListTile<String>(
              title: const Text('Lanche'),
              value: 'Snack',
              groupValue: _type,
              onChanged: (value) {
                setState(() {
                  _type = value!;
                  urlAux = "assets/images/hamburger_icon.webp";
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Bebida'),
              value: 'Drink',
              groupValue: _type,
              onChanged: (value) {
                setState(() {
                  _type = value!;
                  urlAux = "assets/images/drink_icon.png";
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Doce'),
              value: 'Candy',
              groupValue: _type,
              onChanged: (value) {
                setState(() {
                  _type = value!;
                  urlAux = "assets/images/candy_icon.webp";
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addProduct,
              child: const Text('Adicionar Produto'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Produto Adicionado:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Nome: $_name',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Ingredientes: $_ingredients',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Preço: $_price',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'URL da Foto: $_photoUrl',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: QuestionScreen(),
  ));
}