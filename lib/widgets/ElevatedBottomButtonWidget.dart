import 'package:flutter/material.dart';

class ElevatedBottomButtonWidget extends StatefulWidget {
  const ElevatedBottomButtonWidget(
      {required this.name, required this.onPressed, Key? key})
      : super(key: key);

  final String name;
  final Function onPressed;

  @override
  State<ElevatedBottomButtonWidget> createState() =>
      _ElevatedBottomButtonWidget();
}

class _ElevatedBottomButtonWidget extends State<ElevatedBottomButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          widget.onPressed();
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          shadowColor: Colors.black,
          elevation: 1,
        ),
        child: Text(
          widget.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
