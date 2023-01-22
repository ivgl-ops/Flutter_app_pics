import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:provider/provider.dart';
import 'package:test_pics/data/user_data.dart';
import 'package:test_pics/view/auth_view.dart';
import 'package:test_pics/view/contant_view.dart';
import 'package:test_pics/view/detail_pics.dart';
import 'package:test_pics/widget_model/user_code_model.dart';
import 'package:test_pics/widget_model/user_model.dart';

import 'widget_model/pics_model.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await UserData.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    bool login;
    login = UserData.getLogin() ?? false;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserModel()),
        ChangeNotifierProvider(create: (context) => UserCode()),
        ChangeNotifierProvider(create: (context) => PicsModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'test pics',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        builder: (context, child) => Stack(
          children: [child!, const DropdownAlert()],
        ),
        home: login ? const ContantView() : const AuthView(),
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/detail_pics': (context) => const DetailPics(),
          '/login': ((context) => const AuthView()),
          '/contant': ((context) => const ContantView())
        },
      ),
    );
  }
}
