part of 'person_slider_view_bloc.dart';

@immutable
abstract class PersonSliderViewState {}


class PersonSliderViewLoading extends PersonSliderViewState {}

class PersonSliderViewSuccess extends PersonSliderViewState {
  final List<PersonCardInputModel> cardModels;

  PersonSliderViewSuccess(this.cardModels);
}

class CastAndCrewCredit extends PersonSliderViewState {
  final List<PersonCardInputModel> cast;
  final List<PersonCardInputModel> crew;

  CastAndCrewCredit(this.cast, this.crew);
}

class PersonSliderViewError extends PersonSliderViewState {
  final dynamic error;

  PersonSliderViewError(this.error);
}
