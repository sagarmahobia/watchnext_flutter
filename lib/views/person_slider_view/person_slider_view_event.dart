part of 'person_slider_view_bloc.dart';

@immutable
abstract class VideoSliderViewEvent {}

class LoadItemsEvent extends VideoSliderViewEvent {

  final String url;

  final bool isCredit;
  LoadItemsEvent(this.url, {this.isCredit = false});
}
