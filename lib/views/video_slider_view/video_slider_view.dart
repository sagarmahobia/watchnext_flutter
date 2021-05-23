import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchnext/views/video_slider_view/video_card_view/video_card_input_model.dart';
import 'package:watchnext/views/video_slider_view/video_card_view/video_card_view.dart';
import 'package:watchnext/views/video_slider_view/video_slider_input_model.dart';

import 'video_slider_view_bloc.dart';

class VideoSliderView extends StatefulWidget {
  final VideoSliderInputModel inputModel;

  VideoSliderView({this.inputModel});

  @override
  _VideoSliderViewState createState() => _VideoSliderViewState(this.inputModel);
}

class _VideoSliderViewState extends State<VideoSliderView> {
  final VideoSliderInputModel inputModel;

  VideoSliderViewBloc bloc;

  bool isVisible = true;

  _VideoSliderViewState(this.inputModel);

  @override
  void initState() {
    super.initState();
    bloc = VideoSliderViewBloc(this.inputModel.id, this.inputModel.pictureType);
    bloc.add(LoadItemsEvent());
    bloc.listen((state) {
      if (state is VideoSliderViewSuccess) {
        setState(
          () {
            if (state.cardModels.isEmpty) {
              this.isVisible = false;
            }
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        margin: EdgeInsets.only(top: 16.0),
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, VideoSliderViewState state) {
            if (state is VideoSliderViewSuccess) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(left: 16.0, right: 8.0, bottom: 8.0),
                      child: Text(
                        "Videos",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      height: 182,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: getShowCards(state.cardModels),
                      ),
                    )
                  ],
                ),
              );
            }
            if (state is VideoSliderViewError) {
              debugPrint(state.error.toString());

              return InkWell(
                onTap: () {
                  bloc.add(LoadItemsEvent());
                },
                child: Container(
                  height: 150,
                  child: Center(
                    child: Text("Something went wrong. Tap to try again."),
                  ),
                ),
              );
            }
            return CircularProgressIndicator(
              strokeWidth: 2,
            );
          },
        ),
      ),
    );
  }

  List<VideoCardView> getShowCards(List<VideoCardInputModel> cardModels) {
    List<VideoCardView> showCards = List();

    for (VideoCardInputModel model in cardModels) {
      showCards.add(
        VideoCardView(
          inputModel: model,
        ),
      );
    }
    return showCards;
  }
}
