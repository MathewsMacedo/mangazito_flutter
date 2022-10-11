import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/MangaListItem.dart';
import '../utils/api.dart';
import '../utils/constants.dart';
import '../widgets/MangaListItemWidget.dart';

class FavoritesShow extends StatefulWidget {
  FavoritesShow({Key? key}) : super(key: key);

  @override
  State<FavoritesShow> createState() => _FavoritesShowState();
}

class _FavoritesShowState extends State<FavoritesShow> {
  List<MangaListItem> mangaItems = [];
  int _page = 0;
  bool _loading = false;
  int _order = 1;
  String _search = "";

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_infiniteScrolling);
    _getMangaList();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  _infiniteScrolling() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_loading) {
      _loading = true;
      _getMangaList();
    }
  }

  _getMangaList() {
    Api().getFavoriteMangaListPerPage(token).then((response) {
      if (response.statusCode == 200) {
        _loadMangaInfo(response);
      }
    });
  }

  _loadMangaInfo(dynamic response) {
    dynamic decode = json.decode(response.body);

    if (decode['series'] != null) {
      List<dynamic> mangaList = List.from(decode['series']);
      for (var e in mangaList) {
        dynamic item = MangaListItem.fromJson(e);
        if (!mangaItems.contains(item)) {
          mangaItems.add(item);
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Favoritos",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black)),
      ),
      body: ListView(
        children: mangaItems
            .map(
              (e) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: MangaListItemWidget(
                        photo: e.photo,
                        title: e.title,
                        categories: e.categories,
                        lang: e.lang,
                        finish: e.finish,
                        onTap: () {
                          Navigator.pushNamed(context, '/manga', arguments: {
                            "id": e.id,
                            "title": e.title,
                            "photo": e.photo,
                            "categories": e.categories,
                            "lang": e.lang,
                            "finish": e.finish,
                          });
                        },
                      ),
                    ),
                  ]),
            )
            .toList(),
      ),
    );
  }
}
