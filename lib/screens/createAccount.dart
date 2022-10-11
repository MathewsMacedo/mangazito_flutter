import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/api.dart';
import '../utils/constants.dart';
import '../widgets/ElevatedBottomButtonWidget.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final usertextController = TextEditingController();
  final passwordtextController = TextEditingController();
  bool _validate = false;
  final List<String> images = [
    "http://pm1.narvii.com/6785/0c85f7e3e9ee662bb22dc17b46df90f71b7948f3v2_00.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9lBx_eyBVXojF2ZG2UPX_FMI4ZibzKggocNnCMBcpWDZPEQosHKnfVCQBar74KlW5ofU&usqp=CAU",
    "https://pbs.twimg.com/media/ExlatWzXAAgXMzi.jpg"
  ];
  int _value = 0;

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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Escolha uma foto de perfil: ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _value = 0;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: _value == 0
                                    ? Color.fromARGB(255, 0, 140, 255)
                                    : Colors.transparent,
                                width: 5),
                            image: DecorationImage(
                              image: NetworkImage(images[0]),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _value = 1;
                          });
                        },
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: _value == 1
                                    ? Color.fromARGB(255, 0, 140, 255)
                                    : Colors.transparent,
                                width: 5),
                            image: DecorationImage(
                              image: NetworkImage(images[1]),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _value = 2;
                          });
                        },
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: _value == 2
                                    ? Color.fromARGB(255, 0, 140, 255)
                                    : Colors.transparent,
                                width: 5),
                            image: DecorationImage(
                              image: NetworkImage(images[2]),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: TextField(
                  controller: usertextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Digite um username",
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
                  controller: passwordtextController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Digite uma senha",
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
                  name: "CRIAR CONTA",
                  onPressed: () async {
                    if (usertextController.text == "" ||
                        passwordtextController.text == "") {
                      _validate = true;
                      setState(() {});
                      return null;
                    } else {
                      await Api()
                          .postUserManga(usertextController.text,
                              passwordtextController.text, images[_value])
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
        ),
      ],
    );
  }
}
