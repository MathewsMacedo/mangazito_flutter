import 'package:flutter/material.dart';

Future<dynamic?> showPageFromBottom(
    BuildContext context, Widget page, double? height) async {
  return await showModalBottomSheet(
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
    ),
    context: context,
    isScrollControlled: true,
    builder: (builder) {
      return FractionallySizedBox(
          heightFactor: height != null ? height : 0.30, child: page);
    },
  );
}
