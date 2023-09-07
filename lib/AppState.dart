import 'package:flutter/material.dart';


class AppState with ChangeNotifier {
  int stateTaskProduto = 0;
  int childCountLen = 0;

  void updateShowTasks(int newValue1, int newValue2) {
    stateTaskProduto = newValue1;
    childCountLen = newValue2;
    notifyListeners();
  }
}

class AppStateCart with ChangeNotifier {
  int stateTaskCart = 0;
  int childCountLenCart = 0;
  Map<String, String> taskQuantities = {};
  int quantidade = 1;
  int sizeCart = 0;

  void quantidadeLanches(){
    quantidade++;
    print(quantidade);
    notifyListeners();
  }

  void updateShowTasksCart(int newValue1, int newValue2) {
    stateTaskCart = newValue1;
    childCountLenCart = newValue2;
    notifyListeners();
  }

  void updateQuantities(String id, String value) {
    taskQuantities[id] = value;
    sizeCart++;
  }
}