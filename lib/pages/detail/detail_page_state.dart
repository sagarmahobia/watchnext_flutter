part of 'detail_page_bloc.dart';

@immutable
abstract class DetailPageState {}

class DetailPageInitial extends DetailPageState {}

class DetailPageLoading extends DetailPageState {}

class DetailPageError extends DetailPageState {
  var e;

  DetailPageError(this.e);
}

class DetailPageLoaded extends DetailPageState {
  final DetailPageStateModels stateModel;

  DetailPageLoaded(this.stateModel);
}
