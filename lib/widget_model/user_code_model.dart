import 'dart:math';

import 'package:flutter/material.dart';


class UserCodeModel extends ChangeNotifier {
  int code = 0;

  void getCode() {
    var random = Random();
    int min = 1000;
    int max = 9999;
    code = min + random.nextInt(max - min);
    notifyListeners();
  }
}
