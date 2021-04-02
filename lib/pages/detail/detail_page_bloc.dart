import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';
import 'package:watchnext/di/injection.dart';
import 'package:watchnext/models/movie-detail-models.dart';
import 'package:watchnext/models/tv-detail-models.dart';
import 'package:watchnext/pages/detail/detail_page_state_model.dart';
import 'package:watchnext/services/tmdb_service.dart';
import 'package:watchnext/utils/genre_utils.dart';
import 'package:watchnext/views/text_banner/text_banner.dart';

part 'detail_page_event.dart';

part 'detail_page_state.dart';

class DetailPageBloc extends Bloc<DetailPageEvent, DetailPageState> {
  TMDBService rest;
  final String type;
  final int id;

  DetailPageBloc(this.type, this.id) : super(DetailPageInitial()) {
    rest = getIt<TMDBService>();
  }

  @override
  Stream<DetailPageState> mapEventToState(
    DetailPageEvent e,
  ) async* {
    if (e is LoadPageDetail) {
      TMDBService rest = getIt<TMDBService>();

      yield DetailPageLoading();
      try {
        Response response = await rest.getDetails(type, id);
        var stateModel = DetailPageStateModels();

        if (this.type == 'movie') {
          MovieDetail movieDetail = movieDetailFromJson(response.bodyString);

          stateModel.backdrop = movieDetail.backdropPath;
          stateModel.poster = movieDetail.posterPath;
          stateModel.title = movieDetail.title;
          stateModel.year = movieDetail.releaseDate?.substring(0, 4) ?? "N/A";

          stateModel.genres = movieDetail.genres
                  ?.map((e) => getMovieGenreById(e.id))
                  ?.toList()
                  ?.join(', ') ??
              "N/A";

          stateModel.voteCount = movieDetail.voteCount.toString();
          stateModel.vote = movieDetail.voteAverage.toString();

          int t = movieDetail.runtime;
          int hours = (t / 60).truncate(); //since both are ints, you get an int
          int minutes = t % 60;

          if (hours == 0 && minutes == 0) {
            stateModel.runtime = "";
          } else if (hours == 0) {
            stateModel.runtime = minutes.toString() + "m";
          } else if (minutes == 0) {
            stateModel.runtime = hours.toString() + "h";
          } else {
            stateModel.runtime =
                hours.toString() + "h " + minutes.toString() + "m";
          }

          stateModel.textBannersInputModels.addAll([
            TextBannerInputModel(
              title: "Overview",
              value: movieDetail.overview,
            ),
            TextBannerInputModel(
              title: "Original Title",
              value: movieDetail.originalTitle ?? "N/A",
            ),
            TextBannerInputModel(
              title: "Original Language",
              value: movieDetail.originalLanguage,
            ),
            TextBannerInputModel(
              title: "Status",
              value: movieDetail.status,
            ),
            //MOVIE
            TextBannerInputModel(
              title: "Release Date",
              value: movieDetail.releaseDate,
            ),
            TextBannerInputModel(
              title: "Budget",
              value: movieDetail.revenue != 0
                  ? "\$ " + movieDetail.budget.toString()
                  : null,
            ),
            TextBannerInputModel(
              title: "Revenue",
              value: movieDetail.revenue != 0
                  ? "\$ " + movieDetail.revenue.toString()
                  : null,
            ),

            TextBannerInputModel(
              title: "Production Companies",
              value: movieDetail.productionCompanies
                      ?.map((e) => e.name)
                      ?.toList()
                      ?.join(", ") ??
                  null,
            ),
            TextBannerInputModel(
              title: "Homepage",
              value: movieDetail.homepage,
            ),
          ]);
          //////todo

        } else if (this.type == 'tv') {
          TvDetail tvDetail = tvDetailFromJson(response.bodyString);

          stateModel.backdrop = tvDetail.backdropPath;
          stateModel.poster = tvDetail.posterPath;
          stateModel.title = tvDetail.name;
          stateModel.year = tvDetail.firstAirDate?.substring(0, 4) ?? "N/A";
          stateModel.genres = tvDetail.genres
                  ?.map((e) => getTvGenreById(e.id))
                  ?.toList()
                  ?.join(', ') ??
              "N/A";

          stateModel.voteCount = tvDetail.voteCount.toString();
          stateModel.vote = tvDetail.voteAverage.toString();

          List<int> episodeRunTime = tvDetail.episodeRunTime;
          if (episodeRunTime != null && episodeRunTime.isNotEmpty) {
            int t = episodeRunTime.first;
            int hours =
                (t / 60).truncate(); //since both are ints, you get an int
            int minutes = t % 60;

            if (hours == 0 && minutes == 0) {
              stateModel.runtime = "";
            } else if (hours == 0) {
              stateModel.runtime = minutes.toString() + "m";
            } else if (minutes == 0) {
              stateModel.runtime = hours.toString() + "h";
            } else {
              stateModel.runtime =
                  hours.toString() + "h " + minutes.toString() + "m";
            }
          } else {
            stateModel.runtime = "";
          }

          stateModel.textBannersInputModels.addAll([
            TextBannerInputModel(
              title: "Overview",
              value: tvDetail.overview,
            ),
            TextBannerInputModel(
              title: "Original Title",
              value: tvDetail.originalTitle,
            ),
            TextBannerInputModel(
              title: "Original Language",
              value: tvDetail.originalLanguage,
            ),
            TextBannerInputModel(
              title: "Show Status",
              value: tvDetail.status,
            ),

            TextBannerInputModel(
              title: "First Air Date",
              value: tvDetail.firstAirDate,
            ), //
            TextBannerInputModel(
              title: "Last Air Date",
              value: tvDetail.lastAirDate,
            ), //
            TextBannerInputModel(
              title: "Networks",
              value:
                  tvDetail.networks?.map((e) => e.name)?.toList()?.toString() ??
                      null,
            ), //
            TextBannerInputModel(
              title: "Production Companies",
              value: tvDetail.productionCompanies
                      ?.map((e) => e.name)
                      ?.toList()
                      ?.join(", ") ??
                  null,
            ),
            TextBannerInputModel(
              title: "Homepage",
              value: tvDetail.homepage,
            ),
          ]);
        }

        yield DetailPageLoaded(stateModel);
      } catch (e) {
        yield DetailPageError(e);
      }
    }
  }
}
