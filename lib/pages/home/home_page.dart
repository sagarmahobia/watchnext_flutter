import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchnext/res/app_colors.dart';
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

class IntCubit extends Cubit<int> {
  IntCubit() : super(0);

  void setValue(int value) {
    emit(value);
  }
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = IntCubit();
  List<GlobalKey<NavigatorState>> keys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];
  var pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _currentIndex.stream.listen((event) {
      setState(() {
        pageController.jumpToPage(event);
      });
    });
  }

  Future<bool> _willPopCallback() async {
    var currentState = keys[_currentIndex.state].currentState;
    var canPop = currentState?.canPop();
    if (canPop ?? false) {
      currentState?.pop();
      return false;
    }

    if (_currentIndex.state != 0) {
      _currentIndex.setValue(0);

      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: accentColor,
        onTap: (int index) {
          if (_currentIndex.state == index) {
            while (keys[_currentIndex.state].currentState?.canPop() ?? false) {
              keys[_currentIndex.state].currentState?.pop();
            }
            return;
          }
          // pageController.jumpToPage(page);
          _currentIndex.setValue(index);
        },
        currentIndex: _currentIndex.state,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movies"),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: "TV Shows"),
        ],
      ),
      body: WillPopScope(
        onWillPop: _willPopCallback,
        child: PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomeView(),
            MoviesView(),
            ShowsView(),
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
    );
  }
}
