import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:watchnext/views/ad_views/ad_widget.dart';
import 'package:watchnext/views/video_slider_view/video_card_view/video_card_input_model.dart';
import 'package:watchnext/views/video_slider_view/video_card_view/video_card_view.dart';

class VideoSliderView extends StatefulWidget {
  final List<VideoCardInputModel> cardModels;

  const VideoSliderView({Key? key, required this.cardModels});

  @override
  _VideoSliderViewState createState() => _VideoSliderViewState();
}

class _VideoSliderViewState extends FullAdWidgetState<VideoSliderView> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible && widget.cardModels.isNotEmpty,
      child: Container(
          margin: EdgeInsets.only(top: 16.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 8.0, bottom: 8.0),
                  child: Text(
                    "Videos",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  height: 182,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: widget.cardModels
                        .map(
                          (e) => InkWell(
                            onTap: () {
                              var call = () {
                                launchUrlString(e.url,
                                mode:
                                    LaunchMode.inAppWebView
                                );
                              };

                              if (super.interstitialAd != null) {
                                super.interstitialAd?.show();
                                super.interstitialAd?.fullScreenContentCallback =
                                    FullScreenContentCallback(
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
                            child: VideoCardView(
                              inputModel: e,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
