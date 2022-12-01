import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:watchnext/res/app_colors.dart';

//todo note
/*
"logo_sizes": [
  "w45",
  "w92",
  "w154",
  "w185",
  "w300",
  "w500",
  "original"
],


"still_sizes": [
  "w92",
  "w185",
  "w300",
  "original"
]*/
String getImageUrl(String path) => "https://image.tmdb.org/t/p/w300" + path;

/*
"poster_sizes": [
   "w92",
   "w154",
   "w185",
   "w342",
   "w500",
   "w780",
   "original"
 ],
*/

String getImageUrlPosterLQ(String path) => "https://image.tmdb.org/t/p/w500" + path;

/*

"backdrop_sizes": [
  "w300",
  "w780",
  "w1280",
  "original"
],

*/
String getImageUrlBackdropLQ(String path) => "https://image.tmdb.org/t/p/w780" + path;
/*
  "profile_sizes": [
  "w45",
  "w185",
  "h632",
  "original"
  ],
*/
String getImageUrlProfileLQ(String path) => "https://image.tmdb.org/t/p/h632" + path;

String getImageUrlHq(String path) => "https://image.tmdb.org/t/p/original" + path;

FadeInImage getImage(
  String str, {
  double? height = 180,
  double? width = 50,
  fit = BoxFit.fitWidth,
}) {
  return FadeInImage.memoryNetwork(
    placeholder: kTransparentImage,
    imageErrorBuilder: (context, error, stackTrace) {
      return Container(
        height: height,
        width: width,
        child: Center(
          child: Icon(
            Icons.broken_image_rounded,
            size: 50,
            color: Colors.white24,
          ),
        ),
      );
    },
    image: str,
    fit: fit,
    height: height,
    width: width,
  );
}

getSliderShimmer() {
  return SingleChildScrollView(
    physics: NeverScrollableScrollPhysics(),
    scrollDirection: Axis.horizontal,
    child: Shimmer.fromColors(
      baseColor: darkBackGround,
      highlightColor: lightBackGround,
      child: Row(
        children: [0, 1, 2, 4]
            .map(
              (e) => Container(
                width: 135,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                padding: EdgeInsets.all(4),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 252,
                        decoration: BoxDecoration(
                          color: lightBackGround,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                      ),
                      // Container(
                      //   height: 20,
                      //   margin: EdgeInsets.only(top: 8, right: 16),
                      //   decoration: BoxDecoration(
                      //     color: lightBackGround,
                      //   ),
                      // ),
                      // Container(
                      //   height: 20,
                      //   margin: EdgeInsets.only(top: 4, bottom: 8, right: 64),
                      //   decoration: BoxDecoration(
                      //     color: lightBackGround,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    ),
  );
}
