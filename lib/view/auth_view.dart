import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_pics/data/user_data.dart';
import 'package:test_pics/view/auth_code_view.dart';
import 'package:test_pics/widgets/loading_indicator.dart';

import '../widget_model/user_code_model.dart';
import '../widget_model/user_model.dart';
import '../widgets/custom_text.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  late TextEditingController phoneNumber;
  bool loading = false;

  void loadData() async {
    Timer(const Duration(seconds: 2), () {
      setState(() {
        loading = true;
      });
    });
  }

  @override
  void dispose() {
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    phoneNumber = TextEditingController();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: const CustomText(
            text: "Pics app",
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
        ),
        body: loading
            ? Form(
                key: formKey,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          child: const CustomText(
                            text: "Введите свой номер телефона",
                            size: 20,
                            fontWeight: FontWeight.bold,
                            align: TextAlign.center,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, top: 40, bottom: 10),
                          height: 50,
                          width: 200,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 11 ||
                                  value.length > 11) {
                                return 'Неправильно набран номер';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                isCollapsed: true,
                                errorStyle: GoogleFonts.montserrat(color: Colors.red),
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
                                  context
                                      .read<UserModel>()
                                      .getNumber(phoneNumber.text),
                                  context.read<UserCode>().getCode(),
                                  UserData.setUserNumber(Provider.of<UserModel>(
                                          context,
                                          listen: false)
                                      .phone),
                                  // Validate returns true if the form is valid, or false otherwise.
                                  if (formKey.currentState!.validate())
                                    {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AuthCodeView()),
                                      )
                                    }
                                },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                fixedSize: const Size(250, 60),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            child: const CustomText(
                              text: "Запросить смс-код",
                              fontWeight: FontWeight.bold,
                              size: 15,
                              color: Colors.white,
                            ))
                      ]),
                ),
              )
            : const LoadingIndicator(size: 120));
  }
}
