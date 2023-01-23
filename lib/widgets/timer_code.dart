import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:provider/provider.dart';

import '../widget_model/user_code_model.dart';

class TimerCode extends StatefulWidget {
  const TimerCode({super.key});

  @override
  State<TimerCode> createState() => _TimerCodeState();
}

class _TimerCodeState extends State<TimerCode> {
  late Timer timer;
  int start = 3;
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
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start != 0) {
          setState(() {
            start--;
          });
        } else {
          setState(() {
            timer.cancel();
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
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return check
        ? Text("Вы можете запросить новый код через: ${start.toString()}")
        : GestureDetector(
            child: const Text("Отправить код повторно"),
            onTap: () {
              check = true;
              start = 3;
              startTimer();
              Timer(const Duration(seconds: 2), () {
                success();
              });
            },
          );
  }
}
