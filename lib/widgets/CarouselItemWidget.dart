import 'package:flutter/material.dart';

class CarouselItemsWidget extends StatelessWidget {
  const CarouselItemsWidget(
      {required this.photo, required this.title, Key? key});
  final String photo;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
          image: NetworkImage(photo),
          fit: BoxFit.fill,
        ),
      ),
      constraints: const BoxConstraints(maxHeight: 50, minHeight: 50),
    );
  }
}
