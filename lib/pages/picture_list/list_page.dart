import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/views/picture_list_view/picture_list.dart';

class ListPage extends StatefulWidget {
  final String url;
  final String pictureType;

  const ListPage({Key key, this.url, this.pictureType,}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState(this.url, this.pictureType);
}

class _ListPageState extends State<ListPage> {
  final String url;

  final String pictureType;

  _ListPageState(this.url, this.pictureType);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(""),),
      body: Container(
        color: backGroundColor,
        child: PictureListView(
        url: this.url,
        pictureType: this.pictureType,
      ),
    ),);
  }
}
