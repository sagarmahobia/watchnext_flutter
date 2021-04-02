import 'package:flutter/material.dart';
import 'package:watchnext/pages/home/home_page.dart';
import 'package:watchnext/res/app_colors.dart';

import 'di/injection.dart';

void main() {
  configureInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WatchNext',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.dark,
          accentColor: accentColor
      ),
      home: HomePage(),
    );
  }
}
