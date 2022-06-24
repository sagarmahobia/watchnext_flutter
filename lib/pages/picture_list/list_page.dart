import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/views/picture_list_view/picture_list.dart';

class ListPage extends StatefulWidget {
  final String url;
  final String pictureType;

  final String title;

  const ListPage({Key? key, required this.url, required this.pictureType, required this.title})
      : super(key: key);

  @override
  _ListPageState createState() =>
      _ListPageState(this.url, this.pictureType, this.title);
}

class _ListPageState extends State<ListPage> {
  final String url;

  final String pictureType;

  final String title;

  _ListPageState(this.url, this.pictureType, this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(this.title),
      ),
      body: Container(
        color: backGroundColor,
        child: PictureListView(
          url: this.url,
          pictureType: this.pictureType,
        ),
      ),
    );
  }
}
