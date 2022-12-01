part of 'season_detail_bloc.dart';

@immutable
abstract class SeasonDetailState {}


class SeasonDetailsLoading extends SeasonDetailState {}

class SeasonDetailsLoaded extends SeasonDetailState {
  final SeasonDetailModel seasonDetail;

  SeasonDetailsLoaded(this. seasonDetail);
}

class SeasonDetailsLoadError extends SeasonDetailState {}
