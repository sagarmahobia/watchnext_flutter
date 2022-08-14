import 'package:flutter/material.dart';

class TextBannerInputModel {
  final String title;
  final String? value;

  TextBannerInputModel({required this.title, required this.value});
}

class TextBanner extends StatelessWidget {
  final String title;
  final String? value;

  const TextBanner({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value != null && (value?.isNotEmpty??false),
      child: Container(
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
                value ?? "",
                style: TextStyle(
                  color: Colors.white60,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
