part of 'slider_view_bloc.dart';

@immutable
abstract class SliderViewEvent {}

class LoadItemsEvent extends SliderViewEvent {
  final String url;
  final String type;

  LoadItemsEvent(this.url, this.type);
}
