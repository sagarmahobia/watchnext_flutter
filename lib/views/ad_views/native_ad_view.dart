import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:watchnext/admanager.dart';
import 'package:watchnext/res/app_colors.dart';

class NativeAdView extends StatefulWidget {
  const NativeAdView({Key key}) : super(key: key);

  @override
  _NativeAdViewState createState() => _NativeAdViewState();
}

class _NativeAdViewState extends State<NativeAdView> {
  NativeAd myNative;

  bool loaded = false;

  @override
  void initState() {
    super.initState();
    myNative = NativeAd(
      adUnitId: AdManager.nativeAdUnitId,
      //todo ad unit id
      factoryId: 'adFactoryExample',
      customOptions: {},
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            loaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print(err.responseInfo);
          loaded = false;
        },
      ),
    );

    myNative.load();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loaded,
      child: Card(
        color: lightBackGround,
        child: Container(

            padding: EdgeInsets.all(8),
            height: 448,
            child: AdWidget(
              ad: myNative,
            )
            // Text("Ad Goes Here"),
            ),
      ),
    );
  }
}
