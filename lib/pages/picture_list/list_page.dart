import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/views/picture_list_view/picture_list.dart';

class ListPage extends StatefulWidget {
  final String url;
  final String pictureType;

  final String title;

  final Color? color;

  const ListPage(
      {Key? key,
      required this.url,
      required this.pictureType,
      required this.title,
      this.color})
      : super(key: key);

  @override
  _ListPageState createState() =>
      _ListPageState(this.url, this.pictureType, this.title);
}

class _ListPageState extends State<ListPage> with TickerProviderStateMixin {
  final String url;

  final String pictureType;

  final String title;

  _ListPageState(this.url, this.pictureType, this.title);

  final cubit = SingleViewCubit(false);

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(this.title),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 8.0),
          //   child: IconButton(
          //     onPressed: () {
          //       cubit.toggle();
          //       setState(() {
          //         cubit.state ? _animationController.forward() : _animationController.reverse();
          //       });
          //     },
          //     icon: AnimatedIcon(
          //       icon: AnimatedIcons.list_view,
          //       progress: _animationController,
          //     ),
          //   ),
          // )
        ],
      ),
      body: Container(
        color: backGroundColor,
        child: PictureListView(
          url: this.url,
          pictureType: this.pictureType,
          cubit: cubit,
        ),
      ),
    );
  }
}
