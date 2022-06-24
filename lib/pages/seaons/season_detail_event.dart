part of 'season_detail_bloc.dart';

@immutable
abstract class SeasonDetailEvent {}

class LoadSeasonDetail extends SeasonDetailEvent {
  final int tvId;
  final int seasonNumber;

  LoadSeasonDetail(this.tvId, this.seasonNumber);
}
