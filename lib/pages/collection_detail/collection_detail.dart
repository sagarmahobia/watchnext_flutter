import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchnext/pages/collection_detail/collection_detail_bloc.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/res/app_values.dart';
import 'package:watchnext/views/sliderview/sliderview_static.dart';

class CollectionDetail extends StatefulWidget {
  final int id;

  const CollectionDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<CollectionDetail> createState() => _CollectionDetailState();
}

class _CollectionDetailState extends State<CollectionDetail> {
  final dynamic _bloc = CollectionDetailBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(LoadCollectionDetail(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text("Collection Detail"),
      ),
      body: BlocBuilder<CollectionDetailBloc, CollectionDetailState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is CollectionDetailLoaded) {
            return Container(
              color: backGroundColor,
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
                                  errorBuilder: (context, error, xstackTrace) {
                                    return Container(
                                      height: 200,
                                      child: Center(
                                        child: Icon(
                                          Icons.broken_image_outlined,
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
                                  state.model?.posterPath != null ? 130 : 16, 8, 16, 8),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      state.model?.name ?? "N/A",
                                      maxLines: 2,
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        //todo show overview
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(state.model?.overview ?? "N/A", maxLines: 6, overflow: TextOverflow.ellipsis,),
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
                              "https://image.tmdb.org/t/p/original" +
                                  (state.model?.posterPath ?? ""),
                              fit: BoxFit.fitHeight,
                              height: 150,
                              width: 100,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 150,
                                  width: 100,
                                  child: Center(
                                    child: Icon(
                                      Icons.broken_image_outlined,
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

                  StaticShowSlider(type: "movie", title: "Parts", shows: (state.model?.parts))
                ],
              ),
            );
          } else if (state is CollectionDetailLoadError) {
            return Center(
              child: Text("Something went wrong"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
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
