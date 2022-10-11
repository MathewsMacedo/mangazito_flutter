import 'package:flutter/material.dart';
import 'package:manga_app/screens/chapterShow.dart';
import 'package:manga_app/screens/favoritesShow.dart';
import 'package:manga_app/screens/homeList.dart';
import 'package:manga_app/screens/initialApp.dart';
import 'package:manga_app/screens/mangaDetails.dart';
import 'package:manga_app/utils/constants.dart';

import 'app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manga App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: primaryColor,
      ),
      initialRoute: "/login",
      routes: {
        "/login": (context) => InitialApp(),
        "/": (context) => App(),
        "/manga/chapter": (context) => ChapterShow(),
        "/favorites": (context) => FavoritesShow(),
      },
    );
  }
}
