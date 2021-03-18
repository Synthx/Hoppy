import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/screens/screens.dart';
import 'package:hoppy/store/cubit/cubit.dart';

import 'main.dart';

class MainScreen extends StatefulWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
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

  void _goToView(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        SearchBeerDialog.route(),
      );
    } else {
      setState(() {
        _currentViewIndex = index;
      });
      if (index > 2) {
        index -= 1;
      }
      _viewController.jumpToPage(index);
    }
  }

  void _onAskToChangePage(BuildContext context, int pageIndex) {
    _goToView(pageIndex);
    context.read<MainScreenCubit>().resetPageIndex();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainScreenCubit(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<MainScreenCubit, MainScreenState>(
            listenWhen: (prev, curr) =>
                prev.pageIndex != curr.pageIndex && curr.pageIndex != null,
            listener: (context, state) =>
                _onAskToChangePage(context, state.pageIndex!),
          ),
        ],
        child: Scaffold(
          key: _mainScreenKey,
          body: PageView(
            controller: _viewController,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: _views,
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) => _goToView(index),
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
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_box_outlined,
                  size: 30,
                ),
                label: '',
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
        ),
      ),
    );
  }
}
