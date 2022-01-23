import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:watchnext/admanager.dart';
import 'package:watchnext/res/app_colors.dart';

class NativeAdView extends StatefulWidget {
  final bool useCard;

  const NativeAdView(this.useCard, {Key key}) : super(key: key);

  @override
  _NativeAdViewState createState() => _NativeAdViewState(useCard);
}

class _NativeAdViewState extends State<NativeAdView> {
  NativeAd myNative;

  bool loaded = false;

  bool useCard;

  _NativeAdViewState(this.useCard);

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

  getAdWidget() {
    if (useCard) {
      return Container(
        margin: EdgeInsets.only(top: 32),

        child: Card(
          color: lightBackGround,
          child: Container(
            padding: EdgeInsets.all(8),
            height: 380,
            child: AdWidget(
              ad: myNative,
            ),
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(8),
        height: 360,
        child: AdWidget(
          ad: myNative,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loaded,
      child: getAdWidget(),
    );
  }
}
