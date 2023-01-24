import 'package:shared_preferences/shared_preferences.dart';

//Сохранение данных
class UserData {
  static const _keyLogin = 'log_in';
  static const _keyPics = 'get_pic';
  static const _keyUserNumber = 'number_user';
  static late SharedPreferences _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setLogin(bool login) async =>
      await _preferences.setBool(_keyLogin, login);

  static bool? getLogin() => _preferences.getBool(_keyLogin);

  static Future setUserNumber(String number) async =>
      await _preferences.setString(_keyUserNumber, number);

  static String? getUserNumber() => _preferences.getString(_keyUserNumber);

  static Future setPics(List<String> pics) async =>
      await _preferences.setStringList(_keyPics, pics);

  static List<String>? getPics() => _preferences.getStringList(_keyPics);
}
