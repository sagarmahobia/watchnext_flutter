import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer/shimmer.dart';
import 'package:watchnext/adaptive_ui/base_widget.dart';
import 'package:watchnext/pages/search/search_page.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/views/sliderview/showcardview/show_card_input_model.dart';
import 'package:watchnext/views/sliderview/showcardview/show_card_view.dart';
import 'package:watchnext/views/sliderview/showcardview/show_card_wide.dart';

import 'picture_list_bloc.dart';

class SingleViewCubit extends Cubit<bool> {
  SingleViewCubit(super.initialState);

  void toggle() {
    emit(!state);
  }
}

class PictureListView extends StatefulWidget {
  final String url;
  final String pictureType;
  final MyListenable? myListenable;
  final SingleViewCubit? cubit;

  PictureListView({
    Key? key,
    required this.url,
    required this.pictureType,
    this.myListenable,
    this.cubit,
  }) : super(key: key);

  @override
  _PictureListViewState createState() => _PictureListViewState();
}

class _PictureListViewState extends State<PictureListView>
    with AutomaticKeepAliveClientMixin<PictureListView>
    implements MyListener {
  final _pagingController = PagingController<int, ShowCardInputModel>(
      firstPageKey: 1, invisibleItemsThreshold: 10);

  final bloc = PictureListBloc();
  bool _single = false;

  @override
  void initState() {
    super.initState();

    widget.cubit?.stream.listen((event) {
      setState(() {
        _single = event;
      });
    });
    _single = widget.cubit?.state ?? false;

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
      if (widget.myListenable?.getQuery().isNotEmpty ?? false) {
        if (widget.myListenable?.getQuery().isEmpty ?? true) {
          return;
        }
        bloc.query = widget.myListenable?.getQuery() ?? "";
        bloc.add(
          LoadNextPage(
            1,
            widget.url,
            widget.pictureType,
            query: widget.myListenable?.getQuery() ?? "",
          ),
        );
      }
    }
  }

  @override
  void refresh() {
    if (widget.myListenable?.getQuery().isEmpty ?? true) {
      return;
    }
    if (widget.myListenable?.getQuery() == bloc.query) {
      return;
    }
    bloc.query = widget.myListenable?.getQuery() ?? "";

    _pagingController.refresh();

    // bloc.add(LoadNextPage(1, query: myListenable.getQuery()));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BaseWidget(
      builder: (context, sizingInformation) {
        var crossAxisCount = sizingInformation.screenSize.width ~/ 125;
        crossAxisCount = crossAxisCount > 3 ? crossAxisCount : 3;
        return Container(
          color: backGroundColor,
          child: PagedGridView<int, ShowCardInputModel>(
            showNewPageProgressIndicatorAsGridChild: false,
            physics: BouncingScrollPhysics(),
            showNewPageErrorIndicatorAsGridChild: false,
            showNoMoreItemsIndicatorAsGridChild: false,
            pagingController: _pagingController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: _single
                  ? (sizingInformation.screenSize.width / 180)
                  : (100 / 200),
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              crossAxisCount: _single ? 1 : crossAxisCount,
            ),
            builderDelegate: PagedChildBuilderDelegate<ShowCardInputModel>(
                itemBuilder: (context, item, index) {
              return _single
                  ? ShowCardViewWide(inputModel: item)
                  : ShowCardView(inputModel: item);
            }, firstPageProgressIndicatorBuilder: (_) {
              return Container(
                height: 500,
                child: Shimmer.fromColors(
                  baseColor: darkBackGround,
                  highlightColor: lightBackGround,
                  child: GridView.count(
                    scrollDirection: Axis.vertical,
                    crossAxisCount:
                        _single ? 1 : crossAxisCount,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: _single
                        ? (sizingInformation.screenSize.width / 180)
                        : (100 / 200),
                    children: [0, 1, 2, 3, 4, 5, 0, 1, 2]
                        .map((e) => Container(
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }
}
