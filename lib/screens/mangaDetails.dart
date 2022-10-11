import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:manga_app/screens/chapterShow.dart';

import '../models/ChapterListItem.dart';
import '../models/MangaListItem.dart';
import '../utils/api.dart';
import '../utils/constants.dart';
import '../utils/title.dart';
import '../widgets/CategoryItemWidget.dart';
import '../widgets/ChapterListItemWidget.dart';
import '../widgets/LabelFinishedWidget.dart';
import '../widgets/loading.dart';

class MangaDetails extends StatefulWidget {
  const MangaDetails({Key? key}) : super(key: key);

  @override
  State<MangaDetails> createState() => _MangaDetailsState();
}

class _MangaDetailsState extends State<MangaDetails> {
  List<ChapterListItem> chapters = [];
  int _manga_id = 0;
  MangaListItem? _manga;

  _getMangaDetail() {
    Api().getMangaDetails(_manga_id).then((response) {
      dynamic decode = jsonDecode(response.body);
      if (decode['serie'] != null) {
        _manga = MangaListItem.fromJson(decode['serie']);
        setState(() {
          chapters = _manga!.chaptersAll!.map((e) {
            print(e);
            return ChapterListItem.fromJson(e);
          }).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

    _manga_id = arguments["id"];

    if (_manga == null) {
      _getMangaDetail();
    }

    String title = titleHeader(arguments["title"]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black54, //change your color here
        ),
        actions: _manga == null
            ? []
            : <Widget>[
                IconButton(
                  icon: Icon(
                    !_manga!.favorite! ? Icons.favorite_border : Icons.favorite,
                    color: Colors.black54,
                  ),
                  onPressed: () async {
                    await Api()
                        .postFavoriteMangaList(token, _manga_id)
                        .then((response) {
                      if (response.statusCode == 200) {
                        dynamic decode = json.decode(response.body);

                        if (decode['destroy'] != null) {
                          _manga!.favorite = false;
                        } else if (decode['id'] != null) {
                          _manga!.favorite = true;
                        }
                        setState(() {});
                      }
                    });
                  },
                )
              ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 10),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(
                    image: NetworkImage(arguments["photo"]),
                    height: 350,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                arguments["title"].toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
            ),
            _manga == null
                ? Loading()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                onPressed: () {},
                                icon: const Icon(Icons.star_border, size: 16)),
                            Text(
                              "${_manga!.score!} / 10",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          _manga!.categories,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: UnconstrainedBox(
                          alignment: Alignment.centerLeft,
                          child: LabelFinishedWidget(
                            finish: _manga!.finish,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          _manga!.description!,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 50),
                          child: _buildChapters(chapters)),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Column _buildChapters(List<ChapterListItem> chapters) {
    int chapterPerRow = 5;
    int indexChapter = 0;
    List<Widget> rowChapters = [];
    List<Widget> rows = [];

    for (var e in chapters) {
      indexChapter++;
      rowChapters.add(ChapterListItemWidget(
        title: e.name,
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => ChapterShow(),
              settings: RouteSettings(arguments: {
                "id": e.id,
                "id_link": e.idLink,
                "manga_id": _manga_id,
                "name": e.title,
              }),
            ),
          );
        },
      ));

      if (rowChapters.length == chapterPerRow ||
          indexChapter == chapters.length) {
        if (rowChapters.length < chapterPerRow) {
          for (var i = rowChapters.length; i < chapterPerRow; i++) {
            rowChapters.add(const ChapterListItemWidget(title: ""));
          }
        }

        rows.add(Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(children: rowChapters.map((e) => e).toList())));

        rowChapters = [];
      }
    }

    return Column(children: rows);
  }
}
