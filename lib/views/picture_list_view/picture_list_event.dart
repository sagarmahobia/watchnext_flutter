part of 'picture_list_bloc.dart';

@immutable
abstract class PictureListEvent {}

class LoadNextPage extends PictureListEvent {
  final int page;

  final String query;

  LoadNextPage(this.page, {this.query});
}
