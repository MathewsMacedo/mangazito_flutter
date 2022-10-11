import 'package:flutter/material.dart';

enum TabItem { home, favorite, search, settings }

const Map<TabItem, String> tabName = {
  TabItem.home: 'Home',
  TabItem.favorite: 'Favoritos',
  TabItem.search: 'Pesquisa',
  TabItem.settings: 'Configuração',
};

const Map<TabItem, Icon> tabIcon = {
  TabItem.home: Icon(Icons.home),
  TabItem.favorite: Icon(Icons.favorite),
  TabItem.search: Icon(Icons.search),
  TabItem.settings: Icon(Icons.settings),
};
