import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:manga_app/utils/constants.dart';
import 'package:manga_app/widgets/CarouselItemWidget.dart';
import 'package:manga_app/utils/api.dart';

import '../models/MangaListItem.dart';
import '../models/userDetails.dart';
import '../utils/showPageFromBottom.dart';
import '../utils/title.dart';
import '../widgets/CategoryItemWidget.dart';
import '../widgets/MangaListItemWidget.dart';
import '../widgets/loading.dart';
import 'orderShow.dart';

class HomeList extends StatefulWidget {
  HomeList({Key? key}) : super(key: key);

  final List<Widget> sliderBanner = const [
    CarouselItemsWidget(
      photo:
          "https://www.nerdsite.com.br/wp-content/uploads/2022/04/spy-x-family-5.jpg",
      title: "Spy x Family",
    ),
    CarouselItemsWidget(
      photo:
          "https://i.pinimg.com/originals/88/eb/5c/88eb5cc2fcebaeb2bd76987a4ca4ad2b.png",
      title: "Demon Slayer",
    ),
    CarouselItemsWidget(
      photo:
          "https://www.wallpaperup.com/uploads/wallpapers/2016/11/12/1043548/2a07515ae2ec3d4155bf28cfdec4c0b3-700.jpg",
      title: "Hunter x Hunter",
    ),
  ];

  @override
  State<HomeList> createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> with TickerProviderStateMixin {
  TabController? _tabController;
  List<MangaListItem> mangaItems = [];
  int _page = 0;
  String _category = "all";
  bool _loading = false;
  int _order = 1;
  String _search = "";
  UserDetails? user;

  List<dynamic> ListCategories = [];

  List<Widget> categoryItems = [CategoryItemWidget(title: "Todos")];

  _resetPages() {
    _page = 0;
    setState(() {
      mangaItems = [];
    });
    _getMangaList();
  }

  late final ScrollController _scrollController;

  @override
  void initState() {
    if (token != "" && user == null) {
      Api().getUserDetail(token).then((response) {
        dynamic decode = json.decode(response.body);

        if (decode["username"] != null) {
          user = UserDetails.fromJson(decode);
          setState(() {});
        }
      });
    }

    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_infiniteScrolling);
    _getMenuItem();
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
    if (_search != "") {
      Api().getSarchMangaListPerPage(_search, _page, _order).then((response) {
        if (response.statusCode == 200) {
          _loadMangaInfo(response);
        }
      });
    } else if (_category == "all") {
      Api().getAllMangaListPerPage(_page, _order).then((response) {
        _loadMangaInfo(response);
      });
    } else {
      Api()
          .getAllCategoriesMangaListPerPage(_page, _category, _order)
          .then((response) {
        _loadMangaInfo(response);
      });
    }
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
      setState(() {
        _page++;
        _loading = false;
      });
    }
  }

  _getMenuItem() {
    Api().getAllCategories().then((response) {
      dynamic decode = json.decode(response.body);
      if (decode['categories'] != null) {
        List<dynamic> categories = List.from(decode['categories']);

        for (var e in categories) {
          categoryItems.add(CategoryItemWidget(title: e['name']));
        }
        setState(() {
          _tabController =
              TabController(vsync: this, length: categoryItems.length);

          _tabController!.addListener((() {
            if (_tabController!.index == 0) {
              _category = "all";
              _resetPages();
            } else if (_category !=
                categories[_tabController!.index - 1]['name']) {
              _category = categories[_tabController!.index - 1]['name'];
              _resetPages();
            }
          }));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (searchManga != _search) {
      _search = searchManga;
      _tabController!.index = 0;
      setState(() {
        mangaItems = [];
      });

      _resetPages();
    }

    return Scaffold(
      appBar: user == null
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Loading(),
            )
          : AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    titleHeader('Olá, ' + user!.nome),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(
                      child: Row(
                    children: [
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(user!.avatar),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
      body: ListView(
        controller: _scrollController,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 5),
            child: SizedBox(
              height: 150,
              width: double.infinity,
              child: CarouselSlider(
                items: widget.sliderBanner,
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.black26, width: 1)),
              ),
              child: _tabController == null
                  ? SizedBox()
                  : TabBar(
                      labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      controller: _tabController,
                      unselectedLabelColor: Colors.black.withOpacity(0.5),
                      labelColor: Colors.black,
                      indicatorColor: Colors.black,
                      isScrollable: true,
                      tabs: categoryItems,
                    ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Lista de mangas",
                  style: TextStyle(fontSize: 20, color: Colors.black26),
                ),
                Row(
                  children: [
                    const Text(
                      "Ordernar",
                      style: TextStyle(fontSize: 20, color: Colors.black26),
                    ),
                    IconButton(
                        onPressed: () async {
                          await showPageFromBottom(
                                  context, OrderShow(option: _order), 0.50)
                              .then((e) {
                            if (e != null) {
                              _order = e;
                              _resetPages();
                            }
                          });
                        },
                        icon: const Icon(Icons.filter_list_rounded,
                            color: Colors.black54)),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: mangaItems.isEmpty
                ? Loading()
                : Column(
                    children: mangaItems
                        .map((e) => MangaListItemWidget(
                              photo: e.photo,
                              title: e.title,
                              categories: e.categories,
                              lang: e.lang,
                              finish: e.finish,
                              onTap: () {
                                Navigator.pushNamed(context, '/manga',
                                    arguments: {
                                      "id": e.id,
                                      "title": e.title,
                                      "photo": e.photo,
                                      "categories": e.categories,
                                      "lang": e.lang,
                                      "finish": e.finish,
                                    });
                              },
                            ))
                        .toList(),
                  ),
          )
        ],
      ),
    );
  }
}
