import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';

import 'package:provider/provider.dart';
import 'package:test_pics/view/contant_view.dart';

import '../data/user_data.dart';

import '../widget_model/user_code_model.dart';
import '../widgets/timer_code.dart';

class AuthCodeView extends StatefulWidget {
  const AuthCodeView({super.key});

  @override
  State<AuthCodeView> createState() => _AuthCodeViewState();
}

class _AuthCodeViewState extends State<AuthCodeView> {
  late TextEditingController phoneCode;
  late bool accessButton;
  late bool loading;

  @override
  void initState() {
    loading = false;
    accessButton = true;
    AlertController.onTabListener(
        (Map<String, dynamic>? payload, TypeAlert type) {});

    super.initState();
    phoneCode = TextEditingController();
  }

  @override
  void dispose() {
    phoneCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TimerCode(),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 50),
                height: 50,
                width: 150,
                child: TextFormField(
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.length < 4 ||
                        value.length > 4 ||
                        value !=
                            Provider.of<UserCode>(context, listen: false)
                                .code
                                .toString()) {
                      return 'Не правильно набран код';
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration.collapsed(hintText: 'Ваш смс-код'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: phoneCode,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    bool login = true;
                    await UserData.setLogin(login);

                    Timer(const Duration(seconds: 2), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContantView()),
                      );
                    });
                  } else {
                    accessButton = false;
                  }
                },
                child: const Text("Подтвердить"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
