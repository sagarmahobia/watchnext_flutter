import 'package:flutter/material.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/views/home/home_view.dart';
import 'package:watchnext/views/movies/movies_view.dart';
import 'package:watchnext/views/shows/shows_view.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<Widget> tabViews = getTabViews();

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: accentColor,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
            _pageController.jumpToPage(
              _currentIndex,
            );
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movies"),
            BottomNavigationBarItem(icon: Icon(Icons.tv), label: "TV Shows"),
          ],
        ),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: tabViews,
        ),
      ),
    );
  }
}

List<Widget> getTabViews() {
  return [
    HomeView(),
    MoviesView(),
    ShowsView(),
  ];
}
