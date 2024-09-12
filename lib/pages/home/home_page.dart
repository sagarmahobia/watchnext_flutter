import 'package:age_calculator/age_calculator.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';

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
import 'dart:math';

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

    buildNotificationScheduler();
  }

  Future<void> buildNotificationScheduler() async {
    await AwesomeNotifications().cancelAllSchedules();

    //repeat every friday at 8:00PM

    List<String> titles = [
      'Hey there!',
      'Don\'t miss out!',
      'Check this out!',
      'New content alert!',
      'Exciting news!',
      'Just for you!',
      'Special update!',
      'Latest release!',
      'Hot off the press!',
      'Must see!'
    ];

    List<String> bodies = [
      'Check out the latest movies and shows',
      'You won\'t believe what\'s new!',
      'Fresh content just for you!',
      'Discover new favorites!',
      'Your next binge-watch is here!',
      'New episodes available now!',
      'Catch up on the latest!',
      'Don\'t miss the new releases!',
      'Find something new to watch!',
      'Your weekend entertainment is here!'
    ];

    for (var i = 0; i < 52; i++) {
      //include saturday and sunday
      var toAdd = Random().nextInt(2);

      var nextFriday = DateTime.now().add(
        Duration(
          days: DateTime.friday + (i * 7) + toAdd,
        ),
      );
      var timeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();

      var randomTitle = titles[Random().nextInt(titles.length)];

      var randomBody = bodies[Random().nextInt(bodies.length)];

      AwesomeNotifications().createNotification(
        schedule: NotificationCalendar(
          repeats: false,
          allowWhileIdle: true,
          timeZone: timeZone,
          weekday: DateTime.friday,
          hour: 20,
          minute: 0,
          preciseAlarm: true,
          year: nextFriday.year,
          month: nextFriday.month,
          day: nextFriday.day,
        ),
        content: NotificationContent(
          id: 10 + i,
          channelKey: 'reminder_channel',
          title: randomTitle,
          body: randomBody,
        ),
      );
    }

    var timeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    AwesomeNotifications().createNotification(
      schedule: NotificationCalendar(
        repeats: true,
        allowWhileIdle: true,
        timeZone: timeZone,
        weekday: DateTime.friday,
        hour: 20,
        minute: 0,
        preciseAlarm: true,
      ),
      content: NotificationContent(
        id: 10,
        channelKey: 'reminder_channel',
        title: 'Weekend',
        body: 'Looking for something to watch this weekend?',
      ),
    );

    //add one more random no repeat notification with a random date between now and 7 days from now

    var randomDate = DateTime.now().add(Duration(days: Random().nextInt(7)));

    randomDate =
        DateTime(randomDate.year, randomDate.month, randomDate.day, 20, 0);

    var randomTitle = titles[Random().nextInt(titles.length)];

    var randomBody = bodies[Random().nextInt(bodies.length)];

    AwesomeNotifications().createNotification(
      schedule: NotificationCalendar(
        repeats: false,
        allowWhileIdle: true,
        timeZone: timeZone,
        year: randomDate.year,
        month: randomDate.month,
        day: randomDate.day,
        hour: randomDate.hour,
        minute: randomDate.minute,
        preciseAlarm: true,
      ),
      content: NotificationContent(
        id: 11,
        channelKey: 'reminder_channel',
        title: randomTitle,
        body: randomBody,
      ),
    );
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
      bottomNavigationBar:
          BottomAppBar(currentIndex: _currentIndex, keys: keys),
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
          while (widget.keys[widget._currentIndex.state.index].currentState
                  ?.canPop() ??
              false) {
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
