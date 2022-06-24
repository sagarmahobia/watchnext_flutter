import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:watchnext/pages/people_list/people_list_bloc.dart';
import 'package:watchnext/views/person_slider_view/person_card_view/person_card_input_model.dart';
import 'package:watchnext/views/person_slider_view/person_card_view/person_card_view.dart';

class PeopleList extends StatefulWidget {
  final String url;

  const PeopleList({Key? key, required this.url}) : super(key: key);

  @override
  _PeopleListState createState() => _PeopleListState( );
}

class _PeopleListState extends State<PeopleList> {
  PeopleListBloc     bloc = PeopleListBloc( );


  final PagingController<int, PersonCardInputModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    // bloc.add(LoadFirstPage());
    _pagingController.addPageRequestListener((pageKey) {
      bloc.add(LoadNextPage(widget.url,pageKey));
    });

    bloc.stream.listen((PeopleListState state) {
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
