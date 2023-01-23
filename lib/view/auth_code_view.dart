import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:test_pics/view/contant_view.dart';
import 'package:test_pics/widgets/custom_text.dart';

import '../data/user_data.dart';

import '../widget_model/user_code_model.dart';
import '../widgets/timer_code.dart';

class AuthCodeView extends StatefulWidget {
  const AuthCodeView({super.key});

  @override
  State<AuthCodeView> createState() => _AuthCodeViewState();
}

class _AuthCodeViewState extends State<AuthCodeView> {
  late bool accessButton;
  late bool loading;
  late TextEditingController phoneCode;

  @override
  void dispose() {
    phoneCode.dispose();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0.0,
        title: const CustomText(
          text: 'Изменить номер',
          color: Colors.black,
          size: 18,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 40,  right: 30, left: 30),
                child: const CustomText(
                  align: TextAlign.center,
                  text: 'Введите полученный 4-значный цифровой код',
                  size: 18,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: 50,
                width: 100,
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
                      return 'Неправильно \n  набран код';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                  
                    border: InputBorder.none,
                    hintText: 'Ваш смс-код',
                    errorStyle: GoogleFonts.montserrat(color: Colors.red),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: phoneCode,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30, top: 15),
                child: const TimerCode(),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  fixedSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
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
                child: const CustomText(
                  text: "Подтвердить",
                  fontWeight: FontWeight.bold,
                  size: 15,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
