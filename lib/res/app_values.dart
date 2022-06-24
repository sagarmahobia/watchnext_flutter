import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

String getImageUrl(String path) => "https://image.tmdb.org/t/p/w185" + path;

FadeInImage getImage(
  String str, {
  double height = 180,
  double width = 50,
}) =>
    FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      imageErrorBuilder: (context, error, stackTrace) {
        return Container(
          height: height,
          width: width,
          child: Center(
            child: Icon(
              Icons.broken_image_outlined,
              size: 50,
              color: Colors.white24,
            ),
          ),
        );
      },
      image: str,
      fit: BoxFit.fitWidth,
      height: height,
      width: width,
    );
