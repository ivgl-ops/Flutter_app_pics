import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';

import 'package:provider/provider.dart';
import 'package:test_pics/view/contant_view.dart';

import '../data/user_data.dart';
import '../widget_model/user_code_model.dart';

class AuthCodeView extends StatefulWidget {
  const AuthCodeView({super.key});

  @override
  State<AuthCodeView> createState() => _AuthCodeViewState();
}

class _AuthCodeViewState extends State<AuthCodeView> {
  late TextEditingController phoneCode;
  late bool accessButton;

  @override
  void initState() {
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
                        if (formKey.currentState!.validate())
                          {
                            bool login = true;
                            await UserData.setLogin(login);
                            Timer(const Duration(seconds: 2), () {
                              
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  const ContantView()),
                              );
                            });
                          }
                        else
                          {
                            accessButton = false;
                          }
                      },
                  child: const Text("Подтвердить"))
            ],
          ),
        ),
      ),
    );
  }
}

class TimerCode extends StatefulWidget {
  const TimerCode({super.key});

  @override
  State<TimerCode> createState() => _TimerCodeState();
}

class _TimerCodeState extends State<TimerCode> {
  late Timer _timer;
  int _start = 3;
  late bool check;

  void success() {
    Map<String, dynamic> payload = <String, dynamic>{};
    payload["data"] = "content";
    Provider.of<UserCode>(context, listen: false).getCode();
    check = true;
    AlertController.show(
        "Уведомление",
        "Ваш код ${Provider.of<UserCode>(context, listen: false).code}",
        TypeAlert.success,
        payload);
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start != 0) {
          setState(() {
            _start--;
          });
        } else {
          setState(() {
            _timer.cancel();
            check = false;
          });
        }
      },
    );
  }

  @override
  void initState() {
    check = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startTimer();
      success();
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return check
        ? Text("Вы можете запросить новый код через: ${_start.toString()}")
        : GestureDetector(
            child: const Text("Отправить код повторно"),
            onTap: () {
              check = true;
              _start = 3;
              startTimer();
              Timer(const Duration(seconds: 2), () {
                success();
              });
            },
          );
  }
}
