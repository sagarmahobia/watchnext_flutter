part of 'person_slider_view_bloc.dart';

@immutable
abstract class VideoSliderViewState {}

class VideoSliderViewInitial extends VideoSliderViewState {}

class VideoSliderViewLoading extends VideoSliderViewState {}

class VideoSliderViewSuccess extends VideoSliderViewState {
  final List<PersonCardInputModel> cardModels;

  VideoSliderViewSuccess(this.cardModels);
}

class VideoSliderViewError extends VideoSliderViewState {
  var error;

  VideoSliderViewError(this.error);
}
