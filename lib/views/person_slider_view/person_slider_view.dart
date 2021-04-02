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

  PersonSliderView({this.inputModel});

  @override
  _PersonSliderViewState createState() =>
      _PersonSliderViewState(this.inputModel);
}

class _PersonSliderViewState extends State<PersonSliderView> {
  final PersonSliderInputModel inputModel;

  PersonSliderViewBloc bloc;

  _PersonSliderViewState(this.inputModel);

  @override
  void initState() {
    super.initState();
    bloc = PersonSliderViewBloc(this.inputModel.url,
        isCredit: inputModel.isCredit);
    bloc.add(LoadItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: bloc,
      builder: (context, VideoSliderViewState state) {
        if (state is VideoSliderViewSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    inputModel.isCredit ? "Cast" : "People",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(child: Text(inputModel.type)),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PeopleList(
                            url: inputModel.url,
                          ),
                        ),
                      );
                      //
                    },
                    child: Text("SEE ALL"),
                  )
                ],
              ),
              Container(
                height: 230,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: getShowCards(state.cardModels),
                ),
              )
            ],
          );
        }
        if (state is VideoSliderViewError) {
          debugPrint(state.error.toString());

          return Center(
            child: Text("ERROR"),
          );
        }
        return CircularProgressIndicator(
          strokeWidth: 2,
        );
      },
    );
  }

  List<Widget> getShowCards(List<PersonCardInputModel> cardModels) {
    List<Widget> showCards = List();

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
