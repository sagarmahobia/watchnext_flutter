import 'package:age_calculator/age_calculator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchnext/adaptive_ui/util.dart';
import 'package:watchnext/di/injection.dart';
import 'package:watchnext/main.dart';
import 'package:watchnext/pages/search/search_page.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/services/pref_manager.dart';
import 'package:watchnext/views/home/home_view.dart';
import 'package:watchnext/views/movies/movies_view.dart';
import 'package:watchnext/views/shows/shows_view.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class IntCubit extends Cubit<IntIndex> {
  IntCubit() : super(IntIndex(0));

  void setValue(int value) {
    emit(IntIndex(value));
  }
}

class _HomePageState extends State<HomePage> {
  final _currentIndex = IntCubit();
  List<GlobalKey<NavigatorState>> keys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];
  var pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    _currentIndex.stream.listen((event) {
      if (pageController.page?.toInt() != event.index) {
          pageController.jumpToPage(event.index);
      }
    });
  }

  Future<bool> _willPopCallback() async {
    var currentState = keys[_currentIndex.state.index].currentState;
    var canPop = currentState?.canPop();
    if (canPop ?? false) {
      currentState?.pop();
      return false;
    }

    if (_currentIndex.state.index != 0) {
      _currentIndex.setValue(0);

      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: backGroundColor,
              child: WillPopScope(
                onWillPop: _willPopCallback,
                child: PageView(
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    HomeView(),
                    MoviesView(),
                    ShowsView(),
                    SearchPage(cubit: _currentIndex),
                  ]
                      .asMap()
                      .map(
                        (index, e) => MapEntry(
                          index,
                          Navigator(
                            key: keys[index],
                            pages: [
                              MaterialPage(
                                child: Container(
                                  child: e,
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).padding.top,
                                  ),
                                ),
                              ),
                            ],
                            onPopPage: (r, r2) {
                              return r.didPop(r2);
                            },
                          ),
                        ),
                      )
                      .values
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(currentIndex: _currentIndex, keys: keys),
    );
  }
}

class BottomAppBar extends StatefulWidget {
  const BottomAppBar({
    super.key,
    required IntCubit currentIndex,
    required this.keys,
  }) : _currentIndex = currentIndex;

  final IntCubit _currentIndex;
  final List<GlobalKey<NavigatorState>> keys;

  @override
  State<BottomAppBar> createState() => _BottomAppBarState();
}

class _BottomAppBarState extends State<BottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      fixedColor: accentColor,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey,
      onTap: (int index) {
        if (widget._currentIndex.state.index == index) {
          while (widget.keys[widget._currentIndex.state.index].currentState?.canPop() ?? false) {
            widget.keys[widget._currentIndex.state.index].currentState?.pop();
          }
          return;
        }
        // pageController.jumpToPage(page);
        setState(() {
          widget._currentIndex.setValue(index);

        });
      },
      currentIndex: widget._currentIndex.state.index,
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
            ),
            label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.movie_rounded,
            ),
            label: "Movies"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.tv_rounded,
            ),
            label: "TV Shows"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.search_rounded,
            ),
            label: "Search"),
      ],
    );
  }
}
