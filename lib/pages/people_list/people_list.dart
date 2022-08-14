import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:watchnext/pages/people_list/people_list_bloc.dart';
import 'package:watchnext/pages/search/search_page.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/views/person_slider_view/person_card_view/person_card_input_model.dart';
import 'package:watchnext/views/person_slider_view/person_card_view/person_card_view.dart';
import 'package:watchnext/views/person_slider_view/person_slider_input_model.dart';

class PeopleList extends StatefulWidget {
  final PersonSliderInputModel model;

  final MyListenable? myListenable;

  const PeopleList({Key? key, required this.model, this.myListenable}) : super(key: key);

  @override
  _PeopleListState createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> implements MyListener {
  PeopleListBloc bloc = PeopleListBloc();

  final PagingController<int, PersonCardInputModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    // bloc.add(LoadFirstPage());
    _pagingController.addPageRequestListener((pageKey) {
      bloc.add(
          LoadNextPage(widget.model.url, pageKey, query: widget.myListenable?.getQuery() ?? ""));
    });

    bloc.stream.listen((PeopleListState state) {
      if (state is PeoplePageLoaded) {
        if (state.cardModels.isNotEmpty) {
          if (state.cardModels.length < 20) {
            _pagingController.appendLastPage(state.cardModels);
          } else {
            _pagingController.appendPage(state.cardModels, state.nextPageKey);
          }
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
            widget.model.url,
            1,
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
    var pagedGridView = PagedGridView<int, PersonCardInputModel>(
      showNewPageProgressIndicatorAsGridChild: false,
      showNewPageErrorIndicatorAsGridChild: false,
      showNoMoreItemsIndicatorAsGridChild: false,
      pagingController: _pagingController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 100 / 192,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: 3,
      ),
      builderDelegate: PagedChildBuilderDelegate<PersonCardInputModel>(
        itemBuilder: (context, item, index) {
          return PersonCardView(inputModel: item);
        },
      ),
    );

    if (widget.myListenable != null) {
      return pagedGridView;
    } else {
      return Scaffold(
        backgroundColor: backGroundColor,
        appBar: AppBar(
          elevation: 1,
        ),
        body: pagedGridView,
      );
    }
  }
}
