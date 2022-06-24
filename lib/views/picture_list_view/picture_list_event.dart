part of 'picture_list_bloc.dart';

@immutable
abstract class PictureListEvent {}

class LoadNextPage extends PictureListEvent {

  final String url;

  final String pictureType;

  final int page;

  final String query;

  LoadNextPage(this.page, this.url, this.pictureType, {  this.query =""});
}
