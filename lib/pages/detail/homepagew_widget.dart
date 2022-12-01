import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:watchnext/views/ad_views/ad_widget.dart';

class HomepageWidget extends StatefulWidget {
  final String? homepage;

  const HomepageWidget({Key? key, this.homepage}) : super(key: key);

  @override
  State<HomepageWidget> createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends FullAdWidgetState<HomepageWidget> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.homepage?.isNotEmpty ?? false,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: InkWell(
          onTap: () {
            var call = () {
              launch(Uri.parse(widget.homepage ?? "").toString());
            };

            if (super.interstitialAd != null) {
              super.interstitialAd?.show();
              super.interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  call.call();
                  super.interstitialAd?.dispose();
                  super.interstitialAd = null;
                },
              );
            } else {
              call.call();
            }
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              border: Border.all(
                color: Colors.white70,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    // "Find Where To Watch",
                    (widget.homepage ?? "").toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.open_in_new)
              ],
            ),
            padding: EdgeInsets.all(12),
          ),
        ),
      ),
    );
  }
}
