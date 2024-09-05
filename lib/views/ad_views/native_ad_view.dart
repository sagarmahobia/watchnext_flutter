import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:watchnext/admanager.dart';
import 'package:watchnext/res/app_colors.dart';

class NativeAdView extends StatefulWidget {
  final bool useCard;

  const NativeAdView(this.useCard, {Key? key}) : super(key: key);

  @override
  _NativeAdViewState createState() => _NativeAdViewState(useCard);
}

class _NativeAdViewState extends State<NativeAdView> {
  bool loaded = true;
  bool loading = true;
  bool useCard;

  BannerAd? bottomBanner;

  _NativeAdViewState(this.useCard);

  @override
  void initState() {
    super.initState();
    bottomBanner = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.mediumRectangle,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              loaded = true;
              loading = false;
            });
          });
        },
        onAdFailedToLoad: (ad, err) {
          setState(() {
            loaded = false;
            loaded = false;
          });
        },
      ),
    );
    bottomBanner?.load();
    Future.delayed(Duration(seconds: 6), () {
      if (loading) {
        setState(() {
          loaded = false;
        });
      }
    });
  }

  getAdWidget() {
    if (useCard) {
      return Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: lightBackGround,
          borderRadius: BorderRadius.circular(4),
        ),
        child: getAd(),
      );
    } else {
      return getAd();
    }
  }

  getAd() {
    if (loading) {
      return Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
    return Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.center,
      child: AdWidget(ad: bottomBanner!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loaded,
      child: AspectRatio(
        aspectRatio:
            AdSize.mediumRectangle.width / AdSize.mediumRectangle.height,
        child: getAdWidget(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bottomBanner?.dispose();
  }
}
