import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  int stateTaskProduto = 0;

  void updateShowTasks(int newValue) {
    stateTaskProduto = newValue;
    notifyListeners();
  }
}