import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:watchnext/pages/people_list/people_list_bloc.dart';
import 'package:watchnext/views/person_slider_view/person_card_view/person_card_input_model.dart';
import 'package:watchnext/views/person_slider_view/person_card_view/person_card_view.dart';

class PeopleList extends StatefulWidget {
  final String url;

  const PeopleList({Key key, this.url}) : super(key: key);

  @override
  _PeopleListState createState() => _PeopleListState(this.url);
}

class _PeopleListState extends State<PeopleList> {
  PeopleListBloc bloc;

  final PagingController<int, PersonCardInputModel> _pagingController =
      PagingController(firstPageKey: 1);

  final String url;

  _PeopleListState(this.url);

  @override
  void initState() {
    super.initState();
    bloc = PeopleListBloc(this.url);
    // bloc.add(LoadFirstPage());
    _pagingController.addPageRequestListener((pageKey) {
      bloc.add(LoadNextPage(pageKey));
    });

    bloc.listen((PeopleListState state) {
      if (state is PeoplePageLoaded) {
        _pagingController.appendPage(state.cardModels, state.nextPageKey);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagedGridView<int, PersonCardInputModel>(
        showNewPageProgressIndicatorAsGridChild: false,
        showNewPageErrorIndicatorAsGridChild: false,
        showNoMoreItemsIndicatorAsGridChild: false,
        pagingController: _pagingController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 100 / 185,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 3,
        ),
        builderDelegate: PagedChildBuilderDelegate<PersonCardInputModel>(
          itemBuilder: (context, item, index) {
            return PersonCardView(inputModel: item);
          },
        ),
      ),
    );
  }
}
