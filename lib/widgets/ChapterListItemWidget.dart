import 'package:flutter/material.dart';

class ChapterListItemWidget extends StatelessWidget {
  const ChapterListItemWidget({required this.title, this.onTap, Key? key});
  final String title;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: title == "" ? _blankChapter() : _withChapter(),
      ),
    );
  }

  Widget _blankChapter() {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(5),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Widget _withChapter() {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.black54,
        padding: const EdgeInsets.all(5),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
