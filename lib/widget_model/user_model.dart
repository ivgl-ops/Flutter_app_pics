import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  bool checkUserPhone = false;
  String phone = 'None';

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
