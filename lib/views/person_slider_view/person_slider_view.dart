import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchnext/pages/people_list/people_list.dart';
import 'package:watchnext/views/person_slider_view/person_card_view/person_card_input_model.dart';
import 'package:watchnext/views/person_slider_view/person_card_view/person_card_view.dart';
import 'package:watchnext/views/person_slider_view/person_slider_input_model.dart';

import 'person_slider_view_bloc.dart';

class PersonSliderView extends StatefulWidget {
  final PersonSliderInputModel inputModel;

  PersonSliderView({required this.inputModel});

  @override
  _PersonSliderViewState createState() => _PersonSliderViewState();
}

class _PersonSliderViewState extends State<PersonSliderView> {
  PersonSliderViewBloc bloc = PersonSliderViewBloc();

  bool isVisible = true;

  _PersonSliderViewState();

  @override
  void initState() {
    super.initState();
    bloc.add(LoadItemsEvent(widget.inputModel.url, isCredit: widget.inputModel.isCredit));
    bloc.stream.listen((state) {
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
                          widget.inputModel.type,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        widget.inputModel.isCredit ? "Cast" : "People",
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
                          builder: (context) => PeopleList(
                            url: widget.inputModel.url,
                          ),
                        ),
                      );
                      //
                    },
                    child: Text(
                      "MORE",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 16.0),
              child: BlocBuilder(
                bloc: bloc,
                builder: (context, VideoSliderViewState state) {
                  if (state is VideoSliderViewSuccess) {
                    return Container(
                      height: 235,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: getShowCards(state.cardModels),
                      ),
                    );
                  }
                  if (state is VideoSliderViewError) {
                    debugPrint(state.error.toString());

                    return InkWell(
                      onTap: () {
                        bloc.add(LoadItemsEvent(widget.inputModel.url,
                            isCredit: widget.inputModel.isCredit));
                      },
                      child: Container(
                        height: 235,
                        child: Center(
                          child: Text("Something went wrong. Tap to reload."),
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
          ],
        ),
      ),
    );
  }

  List<Widget> getShowCards(List<PersonCardInputModel> cardModels) {
    List<Widget> showCards = [];

    for (PersonCardInputModel model in cardModels) {
      showCards.add(
        Container(
          width: 130,
          padding: EdgeInsets.only(left: 4, right: 4),
          child: PersonCardView(
            inputModel: model,
          ),
        ),
      );
    }
    return showCards;
  }
}
