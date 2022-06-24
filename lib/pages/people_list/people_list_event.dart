part of 'people_list_bloc.dart';

@immutable
abstract class PeopleListEvent {}

class LoadNextPage extends PeopleListEvent {
  final String url;

  final int page;

  LoadNextPage(
    this.url,
    this.page,
  );
}
