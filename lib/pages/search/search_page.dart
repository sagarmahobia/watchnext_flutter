import 'dart:async';

import 'package:flutter/material.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/views/picture_list_view/picture_list.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
    );
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin
    implements MyListenable {
  final _searchController = new TextEditingController();
  var _debounce;
  late TabController _tabController = TabController(length: 2, vsync: this);

  List<MyListener> _listeners = [];

  late PageController _pageController;

  int _currentIndex = 0;

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 300),
      () {
        _listeners.forEach((element) {
          element.refresh();
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);

    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backGroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black54,
          body: Container(
            color: backGroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TextFormField(
                          autofocus: true,
                          maxLines: 1,
                          controller: _searchController,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                            hintText: 'Search Movies',
                            hintStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.white12,
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 8,
                              bottom: 24,
                              top: 24,
                              right: 0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: backGroundColor),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: backGroundColor),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        TabBar(
                          controller: _tabController,
                          onTap: (index) {
                            _pageController.jumpToPage(index);
                          },
                          tabs: [
                            Tab(text: "Movie"),
                            Tab(text: "TV"),
                          ],
                        ),
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: (index) {
                              _tabController.index = index;
                            },
                            children: [
                              Container(
                                color: backGroundColor,
                                child: PictureListView(
                                  url: "search/movie",
                                  pictureType: "movie",
                                  myListenable: this,
                                ),
                              ),
                              Container(
                                color: backGroundColor,
                                child: PictureListView(
                                  url: "search/tv",
                                  pictureType: "tv",
                                  myListenable: this,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _pageController.dispose();
    _debounce?.cancel();
    _listeners.clear();
  }

  void addListener(MyListener listener) {
    _listeners.add(listener);
  }

  String getQuery() {
    return _searchController.text;
  }
}

@override
class MyListener {
  void refresh() {}
}

class MyListenable {
  void addListener(MyListener listener) {}

  String getQuery() {
    return "";
  }
}
