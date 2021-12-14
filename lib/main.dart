import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:watchnext/pages/home/home_page.dart';
import 'package:watchnext/res/app_colors.dart';

import 'di/injection.dart';

void main() {
  configureInjection();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp()); // Wrap your app

  MobileAds.instance.initialize();

  MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: ["B517205846B118100D2DDE8782532B8A", "4D06A259E0AAA30DEA1436D28C159197","Simulator"]));

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: 'WatchNext',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        accentColor: accentColor,
      ),
      home: Container(
        color: backGroundColor,
        child: HomePage(),
      ),
    );
  }
}
