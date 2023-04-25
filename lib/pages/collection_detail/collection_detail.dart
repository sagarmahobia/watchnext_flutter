import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:watchnext/pages/collection_detail/collection_detail_bloc.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/res/app_values.dart';
import 'package:watchnext/views/attribute/tmdb_attribute.dart';
import 'package:watchnext/views/sliderview/sliderview_static.dart';

class CollectionDetail extends StatefulWidget {
  final int id;

  const CollectionDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<CollectionDetail> createState() => _CollectionDetailState();
}

class _CollectionDetailState extends State<CollectionDetail> {
  final _bloc = CollectionDetailBloc();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _bloc.add(LoadCollectionDetail(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        elevation: 1,
        title: Text("Collection Detail"),
      ),
      body: BlocBuilder<CollectionDetailBloc, CollectionDetailState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is CollectionDetailLoaded) {
            return Container(
              // color: backGroundColor,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      color: lightBackGround,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/original" +
                                        (state.model?.backdropPath ?? ""),
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                    errorBuilder:
                                        (context, error, xstackTrace) {
                                      return Container(
                                        height: 200,
                                        child: Center(
                                          child: Icon(
                                            Icons.broken_image_rounded,
                                            size: 75,
                                            color: Colors.white24,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    state.model?.posterPath != null ? 130 : 16,
                                    8,
                                    16,
                                    8),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        state.model?.name ?? "N/A",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Text(
                                                        state.model?.overview ??
                                                            "N/A"),
                                                  ),
                                                );
                                              });
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            state.model?.overview ?? "N/A",
                                            maxLines: 6,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: state.model?.posterPath != null,
                            child: Positioned(
                              bottom: 12,
                              left: 12,
                              child: Image.network(
                                getImageUrlPosterLQ(
                                    state.model?.posterPath ?? ""),
                                fit: BoxFit.fitHeight,
                                height: 150,
                                width: 100,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 150,
                                    width: 100,
                                    child: Center(
                                      child: Icon(
                                        Icons.broken_image_rounded,
                                        size: 50,
                                        color: Colors.white24,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    StaticShowSlider(
                        type: "movie",
                        title: "Parts",
                        shows: (state.model?.parts)),
                    TmdbAttribution(type: Type.wide),
                  ],
                ),
              ),
            );
          } else if (state is CollectionDetailLoadError) {
            return Center(
              child: Text("Something went wrong"),
            );
          }
          return SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Shimmer.fromColors(
              baseColor: darkBackGround,
              highlightColor: lightBackGround,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 190,
                    width: double.infinity,
                    color: Colors.white,
                    margin: EdgeInsets.only(bottom: 12),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        width: 100,
                        color: Colors.white,
                        margin: EdgeInsets.all(16).copyWith(top: 0),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 25,
                              width: double.infinity,
                              color: Colors.white,
                            ),
                            Container(
                              height: 15,
                              margin: EdgeInsets.only(top: 16),
                              width: double.infinity,
                              color: Colors.white,
                            ),
                            Container(
                              height: 15,
                              margin: EdgeInsets.only(top: 8),
                              width: double.infinity,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 16,
                      )
                    ],
                  ),
                  Container(
                    height: 25,
                    width: 150,
                    color: Colors.white,
                    margin: EdgeInsets.all(8).copyWith(top: 0, left: 16),
                  ),
                  SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Shimmer.fromColors(
                        baseColor: darkBackGround,
                        highlightColor: lightBackGround,
                        child: Row(
                          children: [0, 1, 2, 4]
                              .map(
                                (e) => Container(
                                  width: 135,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(4),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 252,
                                          decoration: BoxDecoration(
                                            color: lightBackGround,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(4),
                                            ),
                                          ),
                                        ),
                                        // Container(
                                        //   height: 20,
                                        //   margin: EdgeInsets.only(top: 8, right: 16),
                                        //   decoration: BoxDecoration(
                                        //     color: lightBackGround,
                                        //   ),
                                        // ),
                                        // Container(
                                        //   height: 20,
                                        //   margin: EdgeInsets.only(top: 4, bottom: 8, right: 64),
                                        //   decoration: BoxDecoration(
                                        //     color: lightBackGround,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }
}
