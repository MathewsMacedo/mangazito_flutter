import 'package:flutter/material.dart';

class HomeItemWidget extends StatefulWidget {
  const HomeItemWidget(
      {required this.photo,
      required this.title,
      required this.subtitle,
      Key? key})
      : super(key: key);

  final String photo;
  final String title;
  final String subtitle;

  @override
  State<HomeItemWidget> createState() => _CarouselItemWidget();
}

class _CarouselItemWidget extends State<HomeItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            constraints: const BoxConstraints(minWidth: 300, maxWidth: 300),
            child: Image.network(
              widget.photo,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ListTile(
            title: Text(
              widget.title,
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                widget.subtitle,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black45,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
