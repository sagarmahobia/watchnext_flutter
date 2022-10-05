import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';
import 'package:watchnext/di/injection.dart';
import 'package:watchnext/models/movie-detail-models.dart';
import 'package:watchnext/models/tv-detail-models.dart';
import 'package:watchnext/pages/detail/detail_page_state_model.dart';
import 'package:watchnext/services/tmdb_service.dart';
import 'package:watchnext/utils/genre_utils.dart';
import 'package:watchnext/utils/utils.dart';
import 'package:watchnext/views/text_banner/text_banner.dart';

part 'detail_page_event.dart';

part 'detail_page_state.dart';

class DetailPageBloc extends Bloc<DetailPageEvent, DetailPageState> {
  TMDBService rest = getIt<TMDBService>();

  DetailPageBloc() : super(DetailPageInitial()) {
    on((e, emit) async {
      if (e is LoadPageDetail) {
        emit.call(DetailPageLoading());
        try {
          var stateModel = DetailPageStateModels();

          if (e.type == 'movie') {
            MovieDetail movieDetail =
                (await rest.getMovieDetails(e.id)).body ?? MovieDetail.fromJson(jsonDecode("{}}"));

            stateModel.backdrop = movieDetail.backdropPath;
            stateModel.poster = movieDetail.posterPath;
            stateModel.title = movieDetail.title;
            stateModel.year = movieDetail.releaseDate?.year.toString();

            stateModel.genres =
                movieDetail.genres?.map((e) => getMovieGenreById(e.id ?? 0)).toList().join(', ');

            stateModel.voteCount = movieDetail.voteCount.toString();
            stateModel.vote = movieDetail.voteAverage.toString();

            int? t = movieDetail.runtime;
            int hours = (((t ?? 0) / 60)).truncate(); //since both are ints, you get an int
            int minutes = (t ?? 0) % 60;

            if (hours == 0 && minutes == 0) {
              stateModel.runtime = "";
            } else if (hours == 0) {
              stateModel.runtime = minutes.toString() + "m";
            } else if (minutes == 0) {
              stateModel.runtime = hours.toString() + "h";
            } else {
              stateModel.runtime = hours.toString() + "h " + minutes.toString() + "m";
            }

            stateModel.textBannersInputModels.addAll([
              TextBannerInputModel(
                title: "Overview",
                value: movieDetail.overview ?? "N/A",
              ),
              TextBannerInputModel(
                title: "Original Title",
                value: movieDetail.originalTitle ?? "N/A",
              ),
              TextBannerInputModel(
                title: "Original Language",
                value: movieDetail.originalLanguage ?? "N/A",
              ),
              TextBannerInputModel(
                title: "Status",
                value: movieDetail.status ?? "N/A",
              ),
              //MOVIE
              TextBannerInputModel(
                title: "Release Date",
                value: DateUtil.getPrettyDate(movieDetail.releaseDate),
              ),
              TextBannerInputModel(
                title: "Budget",
                value: (movieDetail.revenue ?? 0) != 0
                    ? "\$ " + (movieDetail.budget?.toString() ?? "N/A")
                    : "N/A",
              ),
              TextBannerInputModel(
                title: "Revenue",
                value: (movieDetail.revenue ?? 0) != 0
                    ? "\$ " + (movieDetail.revenue?.toString() ?? "N/A")
                    : "N/A",
              ),

              TextBannerInputModel(
                title: "Production Companies",
                value: movieDetail.productionCompanies
                    ?.map((e) => e.name ?? "N/A")
                    .toList()
                    .join(", "),
              ),
              TextBannerInputModel(
                title: "Homepage",
                value: movieDetail.homepage ?? "N/A",
              ),
            ]);

            if (movieDetail.belongsToCollection != null) {
              stateModel.showCollection = true;
              stateModel.collectionId = movieDetail.belongsToCollection?.id;
              stateModel.collectionName = movieDetail.belongsToCollection?.name;
              stateModel.collectionImage = movieDetail.belongsToCollection?.backdropPath;
            } else {
              stateModel.showCollection = false;
            }
            stateModel.videos = movieDetail.videos?.results;
            stateModel.similar = movieDetail.similar?.results;

            stateModel.recommendations = movieDetail.recommendations?.results;
            stateModel.credits = movieDetail.credits;
            //////todo what
          } else if (e.type == 'tv') {
            TvDetail tvDetail =
                (await rest.getTvDetails(e.id)).body ?? TvDetail.fromJson(jsonDecode("{}"));

            stateModel.backdrop = tvDetail.backdropPath;
            stateModel.poster = tvDetail.posterPath;
            stateModel.title = tvDetail.name;
            stateModel.year = tvDetail.firstAirDate?.year.toString();
            stateModel.genres =
                tvDetail.genres?.map((e) => getTvGenreById(e.id ?? 0)).toList().join(', ');

            stateModel.voteCount = tvDetail.voteCount.toString();
            stateModel.vote = tvDetail.voteAverage.toString();

            List<int> episodeRunTime = tvDetail.episodeRunTime ?? [];
            if (episodeRunTime.isNotEmpty) {
              int t = episodeRunTime.first;
              int hours = (t / 60).truncate(); //since both are ints, you get an int
              int minutes = t % 60;

              if (hours == 0 && minutes == 0) {
                stateModel.runtime = "";
              } else if (hours == 0) {
                stateModel.runtime = minutes.toString() + "m";
              } else if (minutes == 0) {
                stateModel.runtime = hours.toString() + "h";
              } else {
                stateModel.runtime = hours.toString() + "h " + minutes.toString() + "m";
              }
            } else {
              stateModel.runtime = "";
            }

            stateModel.textBannersInputModels.addAll([
              TextBannerInputModel(
                title: "Overview",
                value: tvDetail.overview ?? "N/A",
              ),
              TextBannerInputModel(
                title: "Original Title",
                value: tvDetail.originalName ?? "N/A",
              ),
              TextBannerInputModel(
                title: "Original Language",
                value: tvDetail.originalLanguage ?? "N/A",
              ),
              TextBannerInputModel(
                title: "Show Status",
                value: tvDetail.status ?? "N/A",
              ),

              TextBannerInputModel(
                title: "First Air Date",
                value: DateUtil.getPrettyDate(tvDetail.firstAirDate),
              ), //
              TextBannerInputModel(
                title: "Last Air Date",
                value: DateUtil.getPrettyDate(tvDetail.lastAirDate),
              ), //
              TextBannerInputModel(
                title: "Networks",
                value: tvDetail.networks?.map((e) => e.name).toList().toString(),
              ), //
              TextBannerInputModel(
                title: "Production Companies",
                value: tvDetail.productionCompanies?.map((e) => e.name).toList().join(", "),
              ),
              TextBannerInputModel(
                title: "Homepage",
                value: tvDetail.homepage ?? "N/A",
              ),
            ]);

            stateModel.seasons = tvDetail.seasons;
            stateModel.videos = tvDetail.videos?.results;
            stateModel.similar = tvDetail.similar?.results;
            stateModel.recommendations = tvDetail.recommendations?.results;
            stateModel.credits = tvDetail.credits;
          }

          emit.call(DetailPageLoaded(stateModel));
        } catch (e) {
          emit.call(DetailPageError(e));
        }
      }
    });
  }
}
