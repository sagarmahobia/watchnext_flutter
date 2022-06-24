import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:watchnext/adaptive_ui/base_widget.dart';
import 'package:watchnext/pages/search/search_page.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/views/sliderview/showcardview/show_card_input_model.dart';
import 'package:watchnext/views/sliderview/showcardview/show_card_view.dart';

import 'picture_list_bloc.dart';

class PictureListView extends StatefulWidget {
  final String url;
  final String pictureType;
  final MyListenable? myListenable;

  PictureListView(
      {Key? key, required this.url, required this.pictureType,   this.myListenable})
      : super(key: key);

  @override
  _PictureListViewState createState() => _PictureListViewState();
}

class _PictureListViewState extends State<PictureListView>
    with AutomaticKeepAliveClientMixin<PictureListView>
    implements MyListener {
  late PagingController<int, ShowCardInputModel> _pagingController;

  PictureListBloc bloc = PictureListBloc();

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController(firstPageKey: 1, invisibleItemsThreshold: 10);

    _pagingController.addPageRequestListener(
      (pageKey) {
        bloc.add(LoadNextPage(pageKey, widget.url, widget.pictureType));
      },
    );

    bloc.stream.listen((PictureListState state) {
      if (state is ListPageLoaded) {
        if (state.cardModels.isNotEmpty) {
          if (state.cardModels.length < 20) {
            _pagingController.appendLastPage(state.cardModels);
          } else
            _pagingController.appendPage(state.cardModels, state.nextPageKey);
        } else {
          _pagingController.appendLastPage([]);
        }
      }
    });

    if (widget.myListenable != null) {
      widget.myListenable?.addListener(this);
      if (widget.myListenable?.getQuery().isNotEmpty??false) {
        if (widget.myListenable?.getQuery().isEmpty??true) {
          return;
        }
        bloc.query = widget.myListenable?.getQuery()??"";
        bloc.add(
          LoadNextPage(
            1,
            widget.url,
            widget.pictureType,
            query: widget.myListenable?.getQuery()??"",
          ),
        );
      }
    }
  }

  @override
  void refresh() {
    if (widget.myListenable?.getQuery().isEmpty??true) {
      return;
    }
    if (widget.myListenable?.getQuery() == bloc.query) {
      return;
    }
    bloc.query =widget. myListenable?.getQuery()??"";

    _pagingController.refresh();

    // bloc.add(LoadNextPage(1, query: myListenable.getQuery()));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseWidget(
      builder: (context, sizingInformation) {
        return Container(
          color: backGroundColor,
          child: PagedGridView<int, ShowCardInputModel>(
            showNewPageProgressIndicatorAsGridChild: false,
            showNewPageErrorIndicatorAsGridChild: false,
            showNoMoreItemsIndicatorAsGridChild: false,
            pagingController: _pagingController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 100 / 200,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: sizingInformation.screenSize.width ~/ 125,
            ),
            builderDelegate: PagedChildBuilderDelegate<ShowCardInputModel>(
              itemBuilder: (context, item, index) {
                return ShowCardView(inputModel: item);
              },
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
