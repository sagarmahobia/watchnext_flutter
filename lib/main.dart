import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:watchnext/pages/home/home_page.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/services/pref_manager.dart';

// import 'package:firebase_core/firebase_core.dart';

import 'di/injection.dart';

class IntIndex {
  final int index;

  IntIndex(this.index);

  @override
  bool operator ==(Object other) => false;
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // showFlutterNotification(message);
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await requestTrackingAuthorization();
  await configureInjection();

  // await Firebase.initializeApp(
  // );

  // NotificationSettings settings =
  //     await FirebaseMessaging.instance.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // FirebaseMessaging.instance.subscribeToTopic("weekend-reminder");

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   showFlutterNotification(message);
  // });

  await MobileAds.instance.initialize();
  await MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
    testDeviceIds: [
      "B517205846B118100D2DDE8782532B8A",
      "4D06A259E0AAA30DEA1436D28C159197",
      "Simulator"
    ],
  ));

  await (getIt<CacheManger>().clearExpiredCache());

  AwesomeNotifications().initialize(
    'resource://drawable/res_app_icon',
    [
      NotificationChannel(
        channelKey: 'reminder_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
      )
    ],
  );

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
        // accentColor: accentColor,
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


     //next todo add filters
     //next todo add keywords
     // next todo enable attribution

     //next todo add rate us logic
     //next add watchlist

*/
