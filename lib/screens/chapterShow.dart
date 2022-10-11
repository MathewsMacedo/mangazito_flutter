import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/api.dart';
import '../utils/title.dart';
import '../widgets/MangaItemWidget.dart';
import '../widgets/loading.dart';

class ChapterShow extends StatefulWidget {
  const ChapterShow({Key? key}) : super(key: key);

  @override
  State<ChapterShow> createState() => _ChapterShowState();
}

class _ChapterShowState extends State<ChapterShow> {
  late TransformationController controller;
  List<MangaItemWidget> mangasImages = [];
  bool _loading = true;

  late int mangaId, id, idLink;

  @override
  void initState() {
    super.initState();
    controller = TransformationController();
  }

  _getMangaList() {
    Api().getImagesManga(mangaId, id, idLink).then((response) {
      dynamic decode = json.decode(response.body);
      if (decode['images'] != null) {
        List<dynamic> mangaList = List.from(decode['images']);
        for (var e in mangaList) {
          mangasImages.add(MangaItemWidget(image: e));
        }
        setState(() {
          _loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

    mangaId = arguments['manga_id'];
    id = arguments['id'];
    idLink = arguments['id_link'];
    if (_loading) {
      _getMangaList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleHeader(arguments["name"]),
          style: const TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white54, //change your color here
        ),
        backgroundColor: Colors.black,
      ),
      body: _loading
          ? Loading()
          : CarouselSlider(
              items: mangasImages,
              options: CarouselOptions(
                autoPlay: false,
                enableInfiniteScroll: false,
                height: double.infinity,
                viewportFraction: 1,
              ),
            ),
      backgroundColor: Colors.black,
    );
  }
}
