import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int count = 0;

  void change() {
    count++;
    notifyListeners();
  }
}
