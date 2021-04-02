import 'package:flutter/material.dart';

class TextBannerInputModel {
  final String title;
  final String value;

  TextBannerInputModel({this.title, this.value});
}

class TextBanner extends StatelessWidget {
  final String title;
  final String value;

  const TextBanner({Key key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Text(
              value ?? "N/A",
              style: TextStyle(
                color: Colors.white60,
              ),
            ),
          )
        ],
      ),
    );
  }
}
