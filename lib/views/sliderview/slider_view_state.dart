part of 'slider_view_bloc.dart';

@immutable
abstract class SliderViewState {}

class SliderViewInitial extends SliderViewState {

}

class SliderViewLoading extends SliderViewState {}

class SliderViewSuccess extends SliderViewState {
  final List<ShowCardInputModel> cardModels;

  SliderViewSuccess(this.cardModels);
}

class SliderViewError extends SliderViewState {
   final dynamic error;

  SliderViewError(this.error);
}
