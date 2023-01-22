import 'package:flutter/material.dart';
import 'package:test_pics/const.dart';

import '../data/user_data.dart';

class PicsModel extends ChangeNotifier {
  List<String> items = [];
  String userNumber = UserData.getUserNumber() ?? 'None';
  List<String> newPics = UserData.getPics() ?? Constants.LISTPICS;
  List<String> pics = UserData.getPics() ?? Constants.LISTPICSITEMS;

  void removePic(int index) {
    items.removeAt(index);
    newPics.removeAt(index);
    print(newPics.length);
    UserData.setPics(newPics);
  }
}
