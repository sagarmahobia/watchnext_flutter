import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:watchnext/pages/search/search_page.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/views/sliderview/showcardview/show_card_input_model.dart';
import 'package:watchnext/views/sliderview/showcardview/show_card_view.dart';

import 'picture_list_bloc.dart';

class PictureListView extends StatefulWidget {
  final String url;
  final String pictureType;
  final MyListenable myListenable;

  PictureListView({Key key, this.url, this.pictureType, this.myListenable})
      : super(key: key);

  @override
  _PictureListViewState createState() =>
      _PictureListViewState(this.url, this.pictureType,
          myListenable: this.myListenable);
}

class _PictureListViewState extends State<PictureListView>
    with AutomaticKeepAliveClientMixin<PictureListView>
    implements MyListener {
  final String url;

  final String pictureType;

  MyListenable myListenable;

  PagingController<int, ShowCardInputModel> _pagingController;

  PictureListBloc bloc;

  _PictureListViewState(this.url, this.pictureType, {this.myListenable});

  @override
  void initState() {
    super.initState();
    _pagingController =
        PagingController(firstPageKey: 1, invisibleItemsThreshold: 10);

    bloc = PictureListBloc(this.url, this.pictureType);

    _pagingController.addPageRequestListener((pageKey) {
      bloc.add(LoadNextPage(pageKey));
    });

    bloc.listen((PictureListState state) {
      if (state is ListPageLoaded) {
        if (state.cardModels.isNotEmpty) {
          if (state.cardModels.length < 20) {
            _pagingController.appendLastPage(state.cardModels);
          } else
            _pagingController.appendPage(state.cardModels, state.nextPageKey);
        } else {
          _pagingController.appendLastPage([]);
        }
        //TODO check if done.
      }
    });

    if (myListenable != null) {
      myListenable.addListener(this);
      if (myListenable.getQuery().isNotEmpty) {
        if (myListenable.getQuery().isEmpty) {
          return;
        }
        bloc.query = myListenable.getQuery();
        bloc.add(LoadNextPage(1, query: myListenable.getQuery()));
      }
    }
  }

  @override
  void refresh() {
    bloc.query = myListenable.getQuery();

    if (myListenable.getQuery().isEmpty) {
      return;
    }
    _pagingController.refresh();

    bloc.add(LoadNextPage(1, query: myListenable.getQuery()));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: backGroundColor,
      child: PagedGridView<int, ShowCardInputModel>(
        showNewPageProgressIndicatorAsGridChild: false,
        showNewPageErrorIndicatorAsGridChild: false,
        showNoMoreItemsIndicatorAsGridChild: false,
        pagingController: _pagingController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 100 / 190,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 3,
        ),
        builderDelegate: PagedChildBuilderDelegate<ShowCardInputModel>(
          itemBuilder: (context, item, index) {
            return ShowCardView(inputModel: item);
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
