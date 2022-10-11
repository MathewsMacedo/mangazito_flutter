import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrderShow extends StatefulWidget {
  OrderShow({Key? key, required this.option}) : super(key: key);

  int option;

  @override
  State<OrderShow> createState() => _OrderShowState();
}

class _OrderShowState extends State<OrderShow> {
  changeOrder(int value) async {
    setState(() {
      widget.option = value;
    });

    await Future.delayed(const Duration(milliseconds: 500), () {});
    Navigator.pop(context, widget.option);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Center(
          child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              child: Text("Ordenar por:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700))),
        ),
        ListTile(
          title: const Text('A - Z',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400)),
          leading: Radio(
            value: 1,
            groupValue: widget.option,
            onChanged: (int? value) async {
              await changeOrder(value!);
            },
          ),
        ),
        ListTile(
          title: const Text('Z - A',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400)),
          leading: Radio(
            value: 2,
            groupValue: widget.option,
            onChanged: (int? value) async {
              await changeOrder(value!);
            },
          ),
        ),
        ListTile(
          title: const Text('Maior Nota',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400)),
          leading: Radio(
            value: 4,
            groupValue: widget.option,
            onChanged: (int? value) async {
              await changeOrder(value!);
            },
          ),
        ),
        ListTile(
          title: const Text('Menor Nota',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400)),
          leading: Radio(
            value: 3,
            groupValue: widget.option,
            onChanged: (int? value) async {
              await changeOrder(value!);
            },
          ),
        ),
      ]),
    );
  }
}
