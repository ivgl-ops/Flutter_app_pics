import 'package:flutter/material.dart';
import 'package:test_pics/const.dart';

import '../data/user_data.dart';

class PicsModel extends ChangeNotifier {
  List<String> items = [];
  String userNumber = UserData.getUserNumber() ?? 'None';
  List<String> newPics = UserData.getPics() ?? Constants().listPics;
  List<String> pics = UserData.getPics() ?? Constants().listPics;

  void removePic(int index) {
    items.removeAt(index);
    newPics.removeAt(index);
    UserData.setPics(newPics);
  }
}
