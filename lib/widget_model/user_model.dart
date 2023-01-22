import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String phone = 'None';
  bool checkUserPhone = false;
  void getNumber(String userPhone) {
    phone = userPhone;
    notifyListeners();
  }

  void checkNumber(String userPhone) {
    if (phone.length < 11) {
      checkUserPhone = true;
    }
    notifyListeners();
  }
}
