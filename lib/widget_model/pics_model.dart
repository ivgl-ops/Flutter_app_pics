import 'package:flutter/material.dart';
import 'package:test_pics/const.dart';

import '../data/user_data.dart';

class PicsModel extends ChangeNotifier {
  List<String> items = [];
  List<String> newPics = UserData.getPics() ?? Constants().listPics;
  List<String> pics = UserData.getPics() ?? Constants().listPics;
  String userNumber = UserData.getUserNumber() ?? 'None';

  void removePic(int index) {
    items.removeAt(index);
    newPics.removeAt(index);
    UserData.setPics(newPics);
  }
}
