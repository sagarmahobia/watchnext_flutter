part of 'people_list_bloc.dart';

@immutable
abstract class PeopleListState {}

class PeoplePageLoaded extends PeopleListState {
  final List<PersonCardInputModel> cardModels;

  final int nextPageKey;

  PeoplePageLoaded(this.cardModels, this.nextPageKey);
}

class PeoplePageLoading extends PeopleListState {}

class PeoplePageError extends PeopleListState {
  final dynamic error;

  PeoplePageError(this.error);
}
