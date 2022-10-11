import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  Loading({this.white, Key? key}) : super(key: key);
  bool? white;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: const EdgeInsets.all(10),
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              backgroundColor:
                  (white != null && white!) ? Colors.white54 : Colors.black26,
              valueColor: AlwaysStoppedAnimation<Color>(
                (white != null && white!)
                    ? Colors.white
                    : Colors.black54, //<-- SEE HERE
              ),
            )));
  }
}
