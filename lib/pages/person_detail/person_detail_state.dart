part of 'person_detail_bloc.dart';

@immutable
abstract class PersonDetailState {}


class PersonDetailLoading extends PersonDetailState {}

class DetailPageError extends PersonDetailState {
  final dynamic e;

  DetailPageError(this.e);
}

class DetailPageLoaded extends PersonDetailState {
  final PersonDetailStateModel stateModel;

  DetailPageLoaded(this.stateModel);
}
