part of 'collection_detail_bloc.dart';

@immutable
abstract class CollectionDetailState {}


class CollectionDetailLoading extends CollectionDetailState {}

class CollectionDetailLoaded extends CollectionDetailState {
final  CollectionDetailModel? model;

  CollectionDetailLoaded(this.model);
}

class CollectionDetailLoadError extends CollectionDetailState {}
