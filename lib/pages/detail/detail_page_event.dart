part of 'detail_page_bloc.dart';

@immutable
abstract class DetailPageEvent {}

class LoadPageDetail extends DetailPageEvent {
  LoadPageDetail();
}
