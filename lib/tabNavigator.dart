import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:manga_app/screens/favoritesShow.dart';
import 'package:manga_app/screens/homeList.dart';
import 'package:manga_app/screens/mangaDetails.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String manga = '/manga';
  static const String favorites = '/favorites';
}

class TabNavigator extends StatelessWidget {
  const TabNavigator({required this.navigatorKey});

  final GlobalKey<NavigatorState> navigatorKey;

  void _push(BuildContext context) {
    Map<String, WidgetBuilder> routeBuilders = _routeBuilders(context);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                routeBuilders[TabNavigatorRoutes.manga]!(context)));
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      TabNavigatorRoutes.root: (context) => HomeList(),
      TabNavigatorRoutes.manga: (context) => const MangaDetails(),
      TabNavigatorRoutes.favorites: (context) => FavoritesShow(),
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    return Navigator(
        key: navigatorKey,
        initialRoute: TabNavigatorRoutes.root,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
              builder: (context) {
                return routeBuilders[routeSettings.name!]!(context);
              },
              settings: routeSettings);
        });
  }
}
