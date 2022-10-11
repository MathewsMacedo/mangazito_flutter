import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SettingsShow extends StatefulWidget {
  SettingsShow({Key? key}) : super(key: key);

  @override
  State<SettingsShow> createState() => _SettingsShowState();
}

class _SettingsShowState extends State<SettingsShow> {
  finish() async {
    await Future.delayed(const Duration(milliseconds: 500), () {});
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Center(
          child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              child: Text("Configuração:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700))),
        ),
        SizedBox(
          width: 150,
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: ElevatedButton(
              onPressed: () async {
                finish();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black54,
              ),
              child: const Text(
                "Logout...",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
