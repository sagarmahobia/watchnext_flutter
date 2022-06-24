part of 'video_slider_view_bloc.dart';

@immutable
abstract class VideoSliderViewEvent {}

class LoadItemsEvent extends VideoSliderViewEvent {
  final int id;

  final String type;
  LoadItemsEvent(this.id, this.type);
}
