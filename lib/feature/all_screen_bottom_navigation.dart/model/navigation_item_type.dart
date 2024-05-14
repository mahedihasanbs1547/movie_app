import 'package:flutter/cupertino.dart';
import 'package:movie_app/feature/favourite/menu_screen.dart';
import 'package:movie_app/feature/home/home_screen.dart';
import 'package:movie_app/feature/search/search_screen.dart';
import 'package:movie_app/feature/setting/setting_screen.dart';

enum NavigationItemType {
  home,
  search,
  favourite,
  settings;

  Widget getView() {
    switch (this) {
      case NavigationItemType.home:
        return  HomeScreen();
      case NavigationItemType.search:
        return const SearchScreen();
      case NavigationItemType.favourite:
        return const FavouriteScreen();
      case NavigationItemType.settings:
        return const SettingScreen();
    }
  }
}
