part of 'picture_list_bloc.dart';

@immutable
abstract class PictureListState {}

class ListPageInitial extends PictureListState {}

class ListPageLoading extends PictureListState {}

class ListPageLoaded extends PictureListState {
  List<ShowCardInputModel> cardModels;

  int nextPageKey;

  ListPageLoaded(this.cardModels, this.nextPageKey);
}

class ListPageError extends PictureListState {
  var e;
  ListPageError(this.e);
}
