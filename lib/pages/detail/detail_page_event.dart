part of 'detail_page_bloc.dart';

@immutable
abstract class DetailPageEvent {}

class LoadPageDetail extends DetailPageEvent {
  final int id;

  final String type;
  LoadPageDetail(  this.id, this.type);
}
