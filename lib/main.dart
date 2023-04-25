import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:watchnext/pages/home/home_page.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/services/pref_manager.dart';

import 'di/injection.dart';

class IntIndex {
  final int index;

  IntIndex(this.index);

  @override
  bool operator ==(Object other) => false;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await requestTrackingAuthorization();

  await configureInjection();

  await MobileAds.instance.initialize();
  await MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
    testDeviceIds: [
      "B517205846B118100D2DDE8782532B8A",
      "4D06A259E0AAA30DEA1436D28C159197",
      "Simulator"
    ],
  ));

  getIt<CacheManger>().clearExpiredCache();

  // printKeys
  getIt<CacheManger>().printKeys();
  runApp(MyApp());
}

Future<void> requestTrackingAuthorization() async {
  await AppTrackingTransparency.requestTrackingAuthorization();
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

/*

     // todo ad saturday and sunday notifications
     // todo block tmdb attribution on release if not needed
     // todo add filters
     // todo add keywords


*/
