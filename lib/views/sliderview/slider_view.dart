import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:watchnext/models/list-models.dart';
import 'package:watchnext/pages/home/home_page.dart';
import 'package:watchnext/pages/picture_list/list_page.dart';
import 'package:watchnext/res/app_colors.dart';
import 'package:watchnext/views/sliderview/showcardview/show_card_view.dart';
import 'package:watchnext/views/sliderview/slider_input_model.dart';
import 'package:watchnext/views/sliderview/slider_view_bloc.dart';

class SliderView extends StatefulWidget {
  final IntCubit reload;
  final SliderInputModel inputModel;
  final List<Show>? shows;

  SliderView({required this.inputModel, this.shows, required this.reload});

  @override
  _SliderViewState createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> {
  SliderViewBloc bloc = SliderViewBloc();

  bool isVisible = true;

  int retries = 0;

  @override
  void initState() {
    super.initState();

    widget.reload.stream.listen((event) {
      if (bloc.state is SliderViewError) {
        bloc.add(LoadItemsEvent(widget.inputModel.url ?? "", widget.inputModel.pictureType ?? ""));
      }
    });

    bloc.add(LoadItemsEvent(widget.inputModel.url ?? "", widget.inputModel.pictureType ?? ""));

    bloc.stream.listen((state) {
      if (state is SliderViewSuccess) {
        setState(
          () {
            if (state.cardModels.isEmpty) {
              this.isVisible = false;
            }
          },
        );
      } else if (state is SliderViewError) {
        // Future.delayed(Duration(seconds: 2), () {
        //   retries++;
        //   if (retries < 1) {
        //     bloc.add(
        //         LoadItemsEvent(widget.inputModel.url ?? "", widget.inputModel.pictureType ?? ""));
        //   }
        // });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        margin: EdgeInsets.only(top: 24),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 16.0,
                          right: 8.0,
                        ),
                        child: Text(
                          widget.inputModel.sliderTitle ?? "",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        getType(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListPage(
                                  url: widget.inputModel.url ?? "",
                                  pictureType: widget.inputModel.pictureType ?? "",
                                  title: (widget.inputModel.sliderTitle ?? "") + " " + getType(),
                                )),
                      );
                    },
                    child: Text(
                      "MORE",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 16.0),
              child: BlocBuilder(
                bloc: bloc,
                builder: (context, SliderViewState state) {
                  if (state is SliderViewSuccess) {
                    return Container(
                      height: 260,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: state.cardModels
                            .map(
                              (e) => Container(
                                width: 135,
                                child: ShowCardView(
                                  inputModel: e,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    );
                  } else if (state is SliderViewError && retries >= 3) {
                    debugPrint(state.error.toString());

                    return InkWell(
                      onTap: () {
                        // bloc.add(LoadItemsEvent(
                        //     widget.inputModel.url ?? "", widget.inputModel.pictureType ?? ""));

                        widget.reload.setValue(0);
                      },
                      child: Container(
                        height: 235,
                        child: Center(
                          child: Text("Something went wrong. Tap to reload."),
                        ),
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getType() {
    if (widget.inputModel.isEmbedded ?? false) {
      return "";
    }
    if (widget.inputModel.pictureType == 'movie') {
      return "Movies";
    } else {
      return "Shows";
    }
  }
}
