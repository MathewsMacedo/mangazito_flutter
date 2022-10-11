import 'package:flutter/material.dart';

import '../utils/constants.dart';

class LabelFinishedWidget extends StatelessWidget {
  const LabelFinishedWidget(
      {required this.finish, this.width, this.fontSize, Key? key});
  final bool finish;
  final double? width;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 110,
      padding: const EdgeInsets.all(5),
      color: finish ? finishedColor : notFinishColor,
      child: Center(
        child: Text(
          finish ? "Finalizado" : "Não finalizado",
          style: TextStyle(fontSize: fontSize ?? 16, color: Colors.white),
        ),
      ),
    );
  }
}
