import 'package:watchnext/models/tv-detail-models.dart';
import 'package:watchnext/views/text_banner/text_banner.dart';

class DetailPageStateModels {
  String backdrop;

  String poster;

  String title;

  String releaseDate;

  String year;

  String runtime;

  String genres;

  String vote;

  String voteCount;

  List<TextBannerInputModel> textBannersInputModels = [];

  List<Season> seasons;

  // collection info
  bool showCollection;
  int collectionId;
  String collectionImage;
  String collectionName;

}
