part of 'slider_view_bloc.dart';

@immutable
abstract class SliderViewEvent {}

class LoadItemsEvent extends SliderViewEvent {
  LoadItemsEvent();
}
