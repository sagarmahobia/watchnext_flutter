part of 'collection_detail_bloc.dart';

@immutable
abstract class CollectionDetailEvent {}

class LoadCollectionDetail extends CollectionDetailEvent{
  final int id;

  LoadCollectionDetail(this.id);
}