part of 'person_detail_bloc.dart';

@immutable
abstract class PersonDetailState {}

class PersonDetailInitial extends PersonDetailState {}

class PersonDetailLoading extends PersonDetailState {}

class DetailPageError extends PersonDetailState {
  var e;

  DetailPageError(this.e);
}

class DetailPageLoaded extends PersonDetailState {
  final PersonDetailStateModel stateModel;

  DetailPageLoaded(this.stateModel);
}
