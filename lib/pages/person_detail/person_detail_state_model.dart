import 'package:watchnext/models/person_detail.dart';
import 'package:watchnext/res/app_values.dart';

class PersonDetailStateModel {
  final PersonDetail? personDetail;

  PersonDetailStateModel(
    this.personDetail,
  );

  List<String> getProfile() {
    return personDetail?.images?.profiles?.map((e) => getImageUrlHq(e.filePath ?? "")).toList() ??
        [];
  }

  Map<String, Object>? getProfileModel() {
    if (personDetail?.images?.profiles?.isNotEmpty ?? false) {
      return {
        "image": personDetail?.images?.profiles?.first.filePath ?? "",
        "height": 190.0,
        "width": ((personDetail?.images?.profiles?.first.aspectRatio ?? 0.0) * 190.0),
        "title": (personDetail?.images?.profiles?.length ?? 0.0).toString() + " Pictures",
        "images": getProfile()
      };
    }
    return null;
  }
}
