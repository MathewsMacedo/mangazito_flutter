import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/api.dart';
import '../utils/constants.dart';
import '../widgets/ElevatedBottomButtonWidget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usertextController = TextEditingController();
  final passwordtextController = TextEditingController();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text("MANGAZITO 🤓",
              style: TextStyle(
                  fontSize: 38,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w700)),
        ),
        Container(
          width: 270,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: TextField(
                  controller: usertextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username",
                    hintText: "Username",
                    prefixIcon: Icon(Icons.people),
                    errorText: (_validate && usertextController.text == "")
                        ? 'Não pode ser vazio'
                        : null,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: TextField(
                  obscureText: true,
                  controller: passwordtextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Senha",
                    hintText: "Senha",
                    prefixIcon: Icon(Icons.key),
                    errorText: (_validate && passwordtextController.text == "")
                        ? 'Não pode ser vazio'
                        : null,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: ElevatedBottomButtonWidget(
                  name: "ENTRAR",
                  onPressed: () async {
                    if (usertextController.text == "" ||
                        passwordtextController.text == "") {
                      _validate = true;
                      setState(() {});
                      return null;
                    } else {
                      await Api()
                          .postUserLogin(usertextController.text,
                              passwordtextController.text)
                          .then((response) {
                        if (response.statusCode == 200) {
                          dynamic decode = json.decode(response.body);
                          if (decode['token'] != null) {
                            token = decode['token'];
                            Navigator.of(context).pushReplacementNamed("/");
                          }
                        }
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
