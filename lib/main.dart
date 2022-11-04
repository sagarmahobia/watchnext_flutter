import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:watchnext/pages/home/home_page.dart';
import 'package:watchnext/res/app_colors.dart';

import 'di/injection.dart';

void main() {
  configureInjection();
  WidgetsFlutterBinding.ensureInitialized();

  requestTrackingAuthorization().then(
    (value) => {
      MobileAds.instance.initialize(),
      MobileAds.instance.updateRequestConfiguration(RequestConfiguration(testDeviceIds: [
        "B517205846B118100D2DDE8782532B8A",
        "4D06A259E0AAA30DEA1436D28C159197",
        "Simulator"
      ])),
      runApp(MyApp())
    },
  );
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

done 7. dates in detail screen.
done 1. movie detail > collection detail .check
todo 2. Images
done 3. Episode detail
todo 4. change layout to make it easy to find genres and change bottom options to home , search, categories etc.
todo 5. put more full screen ads to where?
todo -1. Watch Providers.
done 7. put more Native Ads screen ads.
todo 6. swipe down to refresh in every page.






*/
