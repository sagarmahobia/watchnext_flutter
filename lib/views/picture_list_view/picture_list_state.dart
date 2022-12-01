part of 'picture_list_bloc.dart';

@immutable
abstract class PictureListState {}

class ListPageLoading extends PictureListState {}

class ListPageLoaded extends PictureListState {
  final List<ShowCardInputModel> cardModels;

  final int nextPageKey;

  ListPageLoaded(this.cardModels, this.nextPageKey);
}

class ListPageError extends PictureListState {
  final dynamic e;

  ListPageError(this.e);
}
