import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchnext/pages/picture_list/list_page.dart';
import 'package:watchnext/views/sliderview/showcardview/show_card_input_model.dart';
import 'package:watchnext/views/sliderview/showcardview/show_card_view.dart';
import 'package:watchnext/views/sliderview/slider_view_bloc.dart';
import 'package:watchnext/views/sliderview/slider_input_model.dart';

class SliderView extends StatefulWidget {
  final SliderInputModel inputModel;

  SliderView({required this.inputModel});

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
        Future.delayed(Duration(seconds: 2), () {
          retries++;
          if (retries < 3) {
            bloc.add(
                LoadItemsEvent(widget.inputModel.url ?? "", widget.inputModel.pictureType ?? ""));
          }
        });
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
                        children: getShowCards(state.cardModels),
                      ),
                    );
                  } else if (state is SliderViewError && retries >= 3) {
                    debugPrint(state.error.toString());

                    return InkWell(
                      onTap: () {
                        bloc.add(LoadItemsEvent(
                            widget.inputModel.url ?? "", widget.inputModel.pictureType ?? ""));
                      },
                      child: Container(
                        height: 235,
                        child: Center(
                          child: Text("Something went wrong. Tap to reload."),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      height: 235,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getShowCards(List<ShowCardInputModel> cardModels) {
    List<Widget> showCards = [];

    for (ShowCardInputModel model in cardModels) {
      showCards.add(
        Container(
          width: 135,
          child: ShowCardView(
            inputModel: model,
          ),
        ),
      );
    }
    return showCards;
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
