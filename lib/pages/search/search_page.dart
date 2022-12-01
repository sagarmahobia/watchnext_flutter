import 'dart:async';

import 'package:flutter/material.dart';
import 'package:watchnext/pages/home/home_page.dart';
import 'package:watchnext/pages/people_list/people_list.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/views/person_slider_view/person_slider_input_model.dart';
import 'package:watchnext/views/picture_list_view/picture_list.dart';

class SearchPage extends StatefulWidget {
  final IntCubit cubit;

  const SearchPage({super.key, required this.cubit});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with TickerProviderStateMixin
    implements MyListenable {
  final _searchController = new TextEditingController();
  late TabController _tabController = TabController(length: 3, vsync: this);

  List<MyListener> _listeners = [];

  late PageController _pageController;

  int _currentIndex = 0;

  var _debounce;
  final cubit = SingleViewCubit(false);

  late AnimationController _animationController;

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
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _searchController.addListener(_onSearchChanged);

    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () {
                  widget.cubit.setValue(0);
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 12).copyWith(right: 16),
                  child: TextFormField(
                    autofocus: true,
                    maxLines: 1,
                    controller: _searchController,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    decoration: InputDecoration(
                        isCollapsed: true,
                        hintText: 'Search WatchNext',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 6,
                          bottom: 6,
                        ),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 8.0),
              //   child: IconButton(
              //     onPressed: () {
              //       cubit.toggle();
              //       setState(() {
              //         cubit.state ? _animationController.forward() : _animationController.reverse();
              //       });
              //     },
              //     icon: AnimatedIcon(
              //       icon: AnimatedIcons.list_view,
              //       progress: _animationController,
              //     ),
              //   ),
              // )
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
                      Tab(text: "People"),
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
                            cubit: cubit,
                          ),
                        ),
                        Container(
                          color: backGroundColor,
                          child: PictureListView(
                            url: "search/tv",
                            pictureType: "tv",
                            myListenable: this,
                            cubit: cubit,
                          ),
                        ),
                        Container(
                          color: backGroundColor,
                          child: PeopleList(
                            model: PersonSliderInputModel("search/person", ""),
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
