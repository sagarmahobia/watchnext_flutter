import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:watchnext/pages/image_viewer/image_viewer.dart';
import 'package:watchnext/pages/person_detail/person_detail_bloc.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/res/app_values.dart';
import 'package:watchnext/utils/utils.dart';
import 'package:watchnext/views/ad_views/native_ad_view.dart';
import 'package:watchnext/views/attribute/tmdb_attribute.dart';
import 'package:watchnext/views/sliderview/sliderview_static.dart';
import 'package:watchnext/views/text_banner/text_banner.dart';

class PersonDetailPage extends StatefulWidget {
  final int id;

  const PersonDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _PersonDetailPageState createState() => _PersonDetailPageState();
}

class _PersonDetailPageState extends State<PersonDetailPage> {
  final bloc = PersonDetailBloc();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.add(LoadPersonDetail(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        elevation: 1,
        title: Text("Detail"),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is DetailPageLoaded) {
            DateTime? bday = state.stateModel.personDetail?.birthday;
            DateTime? dday = state.stateModel.personDetail?.deathday;
            Duration? age;
            if (bday != null) {
              age = (dday ?? DateTime.now()).difference(bday);
            }

            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.grey[800],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          getImage(
                            "https://image.tmdb.org/t/p/original" +
                                (state.stateModel.personDetail?.profilePath ?? ""),
                            height: 300 * 0.6,
                            width: 200 * 0.6,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    state.stateModel.personDetail?.name ?? "N/A",
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      (state.stateModel.personDetail?.gender ?? 0) == 1
                                          ? "Female"
                                          : "Male",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(((age?.inDays ?? 0) ~/ 365).toString() + " Years"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  //   child: Text(state.stateModel.personDetail.biography ?? ""),
                  // ),
                  TextBanner(
                    title: "Biography",
                    value: state.stateModel.personDetail?.biography,
                  ),

                  TextBanner(
                    title: "Birthday",
                    value: DateUtil.getPrettyDate(state.stateModel.personDetail?.birthday),
                  ),

                  TextBanner(
                    title: "Place of Birth",
                    value: state.stateModel.personDetail?.placeOfBirth,
                  ),
                  TextBanner(
                    title: "Died",
                    value: state.stateModel.personDetail?.deathday != null
                        ? DateUtil.getPrettyDate(state.stateModel.personDetail?.deathday)
                        : null,
                  ),
                  TextBanner(
                    title: "Also Know As",
                    value: state.stateModel.personDetail?.alsoKnownAs != null
                        ? state.stateModel.personDetail?.alsoKnownAs?.join(", ")
                        : null,
                  ),
                  TextBanner(
                    title: "Known For",
                    value: state.stateModel.personDetail?.knownForDepartment,
                  ),
                  TextBanner(
                    title: "Homepage",
                    value: state.stateModel.personDetail?.homepage,
                  ),

                  NativeAdView(false),
                  Builder(builder: (_) {
                    Map<String, Object>? model = state.stateModel.getProfileModel();
                    if (model?.isNotEmpty ?? false) {
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0).copyWith(top: 24, bottom: 16),
                              child: Text(
                                "Media",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap:(){

                                Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                    builder: (context) => ImageViewer(
                                      model!["images"] as List<String>,
                                      0,
                                    ),
                                  ),
                                );

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: lightBackGround,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                margin: const EdgeInsets.symmetric(horizontal: 6.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Column(
                                    children: [
                                      getImage(getImageUrl(model!["image"] as String),
                                          height: (model["height"] as double),
                                          fit: BoxFit.fitHeight,
                                          width: (model["width"] as double)),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(model["title"] as String),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Container();
                  }),

                  StaticShowSlider(
                    type: "movie",
                    title: "Cast",
                    shows: state.stateModel.personDetail?.movieCredits?.cast,
                  ),
                  StaticShowSlider(
                    type: "movie",
                    title: "Crew",
                    shows: state.stateModel.personDetail?.movieCredits?.crew,
                  ),
                  StaticShowSlider(
                    type: "tv",
                    title: "Cast",
                    shows: state.stateModel.personDetail?.tvCredits?.cast,
                  ),
                  StaticShowSlider(
                    type: "tv",
                    title: "Crew",
                    shows: state.stateModel.personDetail?.tvCredits?.crew,
                  ),
                  NativeAdView(false),
                  TmdbAttribution(type: Type.wide),
                  Container(
                    height: 16,
                  )
                ],
              ),
            );
          } else if (state is DetailPageError) {
            return Center(
              child: Text("Something went wrong"),
            );
          }
          return SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              child: Shimmer.fromColors(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 8, top: 8),
                            height: 150,
                            width: 90,
                            color: Colors.white,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(8),
                                  height: 20,
                                  color: Colors.white,
                                ),
                                Container(
                                  margin: EdgeInsets.all(8).copyWith(right: 156),
                                  height: 20,
                                  color: Colors.white,
                                ),
                                Container(
                                  margin: EdgeInsets.all(8).copyWith(right: 156),
                                  height: 20,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                        margin: EdgeInsets.all(8).copyWith(top: 16),
                        color: Colors.white,
                        width: 120,
                      ),
                      Container(
                        height: 20,
                        margin: EdgeInsets.all(8).copyWith(top: 0),
                        color: Colors.white,
                        width: double.infinity,
                      ),
                      Container(
                        height: 20,
                        margin: EdgeInsets.all(8).copyWith(top: 16),
                        color: Colors.white,
                        width: 120,
                      ),
                      Container(
                        height: 20,
                        margin: EdgeInsets.all(8).copyWith(top: 0),
                        color: Colors.white,
                        width: double.infinity,
                      ),
                      Container(
                        height: 20,
                        margin: EdgeInsets.all(8).copyWith(top: 16),
                        color: Colors.white,
                        width: 120,
                      ),
                      Container(
                        height: 20,
                        margin: EdgeInsets.all(8).copyWith(top: 0),
                        color: Colors.white,
                        width: double.infinity,
                      ),
                      Container(
                        height: 20,
                        margin: EdgeInsets.all(8).copyWith(top: 16),
                        color: Colors.white,
                        width: 120,
                      ),
                      Container(
                        height: 20,
                        margin: EdgeInsets.all(8).copyWith(top: 0),
                        color: Colors.white,
                        width: double.infinity,
                      ),
                      Container(
                        height: 20,
                        margin: EdgeInsets.all(8).copyWith(top: 16),
                        color: Colors.white,
                        width: 120,
                      ),
                      Container(
                        height: 20,
                        margin: EdgeInsets.all(8).copyWith(top: 0),
                        color: Colors.white,
                        width: double.infinity,
                      ),
                      Container(
                        height: 20,
                        margin: EdgeInsets.all(8).copyWith(top: 16),
                        color: Colors.white,
                        width: 120,
                      ),
                      Container(
                        height: 20,
                        margin: EdgeInsets.all(8).copyWith(top: 0),
                        color: Colors.white,
                        width: double.infinity,
                      ),
                    ],
                  ),
                  baseColor: darkBackGround,
                  highlightColor: lightBackGround),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }
}
