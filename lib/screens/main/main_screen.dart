import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/store/cubit/cubit.dart';

import 'explore/explore_view.dart';
import 'favorite/favorite_view.dart';
import 'search/search_view.dart';
import 'settings/settings_view.dart';

class MainScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (_) => MainScreen(),
      );

  @override
  State createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _mainScreenKey = GlobalKey<State>();
  final _viewController = PageController(
    initialPage: 0,
  );
  final List<Widget> _views = [
    ExploreView(),
    SearchView(),
    FavoriteView(),
    SettingsView(),
  ];

  int _currentViewIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<SettingsCubit>().setKey(_mainScreenKey);
  }

  @override
  void dispose() {
    _viewController.dispose();
    super.dispose();
  }

  void goToView(int index) {
    setState(() {
      _currentViewIndex = index;
    });
    _viewController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _mainScreenKey,
      body: PageView(
        controller: _viewController,
        children: _views,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => goToView(index),
        showSelectedLabels: false,
        currentIndex: _currentViewIndex,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Explorer',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: 'Rechercher',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favoris',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Paramètres',
          ),
        ],
      ),
    );
  }
}
