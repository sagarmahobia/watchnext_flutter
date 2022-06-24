import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:watchnext/admanager.dart';

abstract class FullAdWidgetState<T extends StatefulWidget> extends State<T> {
  InterstitialAd? _interstitialAd;

  FullAdWidgetState( );

  set interstitialAd(InterstitialAd? value) {
    _interstitialAd = value;
  }

  InterstitialAd? get interstitialAd => _interstitialAd;

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  void loadAd() {
    InterstitialAd.load(
      adUnitId: AdManager.interstitialAdUnitId, //todo ad unit id
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          this._interstitialAd = ad;
          _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              _interstitialAd?.dispose();
            },
            onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
              ad.dispose();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_interstitialAd != null) {
      _interstitialAd?.dispose();
    }
  }
}
