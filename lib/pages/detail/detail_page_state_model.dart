import 'package:watchnext/models/list-models.dart';
import 'package:watchnext/models/movie-detail-models.dart';
import 'package:watchnext/models/tv-detail-models.dart';
import 'package:watchnext/res/app_values.dart';
import 'package:watchnext/views/text_banner/text_banner.dart';

class DetailPageStateModels {
  String? backdrop;
  String? poster;
  String? title;
  String? releaseDate;
  String? year;
  String? runtime;
  String? genres;
  String? vote;
  String? voteCount;

  String? homepage;

  List<TextBannerInputModel> textBannersInputModels = [];

  List<Season>? seasons;

  // collection info
  bool? showCollection;
  int? collectionId;
  String? collectionImage;
  String? collectionName;

  List<VideosResult>? videos;
  List<Image>? posters;
  List<Image>? backdrops;

  List<Show>? similar;

  List<Show>? recommendations;

  Credits? credits;

  String? contentRating;

  List<String> get5Backdrops() {
    var items = this.backdrops?.map((e) => getImageUrlBackdropLQ(e.filePath ?? "")).toList() ?? [];
    if (items.isNotEmpty) {
      if (items.length >= 5) {
        return items.sublist(0, 5);
      } else
        return items;
    }
    return [];
  }

  List<String> getAllBackdropsInHQ() {
    return this.backdrops?.map((e) => getImageUrlHq(e.filePath ?? "")).toList() ?? [];
  }

  List<String> getAllPostersInHQ() {
    return posters?.map((e) => getImageUrlHq(e.filePath ?? "")).toList() ?? [];
  }

  String getFirstPosterPath() {
    if (posters?.isNotEmpty ?? false) {
      return posters?.first.filePath ?? "";
    } else {
      return "";
    }
  }

  List<Map> getImagesBuilder() {
    List<Map<String, Object>> list = [];

    if (posters?.isNotEmpty ?? false) {
      list.add(_getPosterModel());
    }
    if (backdrops?.isNotEmpty ?? false) {
      list.add(_getBackdropModel());
    }
    return list;
  }

  Map<String, Object> _getBackdropModel() {
    var a = {
      "image": getImageUrlBackdropLQ(backdrops?.first.filePath ?? ""),
      "height": 150.0,
      "width": ((backdrops?.first.aspectRatio ?? 0.0) * 150.0),
      "title": (backdrops?.length ?? 0.0).toString() + " Posters",
      "images": getAllBackdropsInHQ()
    };
    return a;
  }

  Map<String, Object> _getPosterModel() {
    var a = {
      "image": getImageUrlPosterLQ(posters?.first.filePath ?? ""),
      "height": 150.0,
      "width": ((posters?.first.aspectRatio ?? 0.0) * 150.0),
      "title": (posters?.length ?? 0.0).toString() + " Posters",
      "images": getAllPostersInHQ()
    };
    return a;
  }
}
