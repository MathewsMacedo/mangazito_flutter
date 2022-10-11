import 'package:flutter/material.dart';

class CategoryItemWidget extends StatelessWidget {
  CategoryItemWidget({required this.title, Key? key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
