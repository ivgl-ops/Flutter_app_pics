import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_pics/data/user_data.dart';
import 'package:test_pics/view/auth_code_view.dart';

import '../widget_model/user_code_model.dart';
import '../widget_model/user_model.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  late TextEditingController phoneNumber;

  @override
  void initState() {
    super.initState();
    phoneNumber = TextEditingController();
  }

  @override
  void dispose() {
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Аунтификация"),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 50),
                  height: 50,
                  width: 200,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length < 11 ||
                          value.length > 11) {
                        return 'Не правильно набран номер';
                      }
                      return null;
                    },
                    decoration: const InputDecoration.collapsed(
                        hintText: '89832936402'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: phoneNumber,
                  ),
                ),
                ElevatedButton(
                    onPressed: () => {
                          context.read<UserModel>().getNumber(phoneNumber.text),
                          context.read<UserCode>().getCode(),
                          UserData.setUserNumber(
                              Provider.of<UserModel>(context, listen: false).phone),
                          // Validate returns true if the form is valid, or false otherwise.
                          if (formKey.currentState!.validate())
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AuthCodeView()),
                              )
                            }
                        },
                    child: const Text("Запростить смс код"))
              ]),
        ),
      ),
    );
  }
}
