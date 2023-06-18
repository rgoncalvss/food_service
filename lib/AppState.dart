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