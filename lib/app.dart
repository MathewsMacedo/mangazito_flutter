import 'package:flutter/material.dart';
import 'package:manga_app/screens/SearchShow.dart';
import 'package:manga_app/screens/favoritesShow.dart';
import 'package:manga_app/screens/settingsShow.dart';
import 'package:manga_app/tabNavigator.dart';
import 'package:manga_app/tab_item.dart';
import 'package:manga_app/utils/constants.dart';
import 'package:manga_app/utils/showPageFromBottom.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  TabItem _currentTab = TabItem.home;
  final _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.favorite: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.settings: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildOffstageNavigator(TabItem.home),
          _buildOffstageNavigator(TabItem.favorite),
          _buildOffstageNavigator(TabItem.search),
          _buildOffstageNavigator(TabItem.settings),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          _buildItem(TabItem.home),
          _buildItem(TabItem.favorite),
          _buildItem(TabItem.search),
          _buildItem(TabItem.settings),
        ],
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color.fromARGB(255, 42, 42, 42),
        currentIndex: _currentTab.index,
        onTap: (value) async {
          if (value == 0) {
            !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
            _selectTab(TabItem.home);
          }

          if (value == 1) {
            !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
            _selectTab(TabItem.favorite);
            _navigatorKeys[_currentTab]!.currentState!.pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        FavoritesShow(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
          }

          if (value == 3) {
            await showPageFromBottom(context, SettingsShow(), 0.25).then((e) {
              if (e != null) {
                setState(() {
                  searchManga = e;
                  print(e);
                });
              }
            });
          }

          // let system handle back button if we're on the first route
          if (value == 2) {
            !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
            _selectTab(TabItem.home);
            await showPageFromBottom(
                    context,
                    SearchShow(
                      search: searchManga,
                    ),
                    0.30)
                .then((e) {
              if (e != null) {
                setState(() {
                  searchManga = e;
                  print(e);
                });
              }
            });
          }
        },
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: tabIcon[tabItem]!,
      label: tabName[tabItem]!,
    );
  }
}
