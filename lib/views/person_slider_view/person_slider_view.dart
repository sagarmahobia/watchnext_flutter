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
  final PersonSliderViewBloc bloc = PersonSliderViewBloc();

  bool isVisible = true;
  bool hasCast = true;
  bool hasCrew = true;

  _PersonSliderViewState();

  @override
  void initState() {
    super.initState();
    bloc.add(LoadItemsEvent(widget.inputModel.url, isCredit: widget.inputModel.isCredit));
    bloc.stream.listen((state) {
      if (state is PersonSliderViewSuccess) {
        setState(
          () {
            if (state.cardModels.isEmpty) {
              this.isVisible = false;
            }
          },
        );
      } else if (state is CastAndCrewCredit) {
        setState(() {
          hasCast = state.cast.isNotEmpty;
          hasCrew = state.crew.isNotEmpty;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Builder(builder: (context) {
        if (widget.inputModel.isCredit) {
          return Column(
            children: [
              Visibility(
                visible: hasCast,
                child: Container(
                  margin: EdgeInsets.only(top: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 16.0,
                          right: 8.0,
                        ),
                        child: Text(
                          "Cast",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16.0),
                        child: BlocBuilder(
                          bloc: bloc,
                          builder: (context, state) {
                            if (state is CastAndCrewCredit) {
                              return Container(
                                height: 240,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: state.cast.map((e) => getShowCards(e)).toList(),
                                ),
                              );
                            }
                            if (state is PersonSliderViewError) {
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
              ),
              Visibility(
                visible: hasCrew,
                child: Container(
                  margin: EdgeInsets.only(top: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 16.0,
                          right: 8.0,
                        ),
                        child: Text(
                          "Crew",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16.0),
                        child: BlocBuilder(
                          bloc: bloc,
                          builder: (context, PersonSliderViewState state) {
                            if (state is CastAndCrewCredit) {
                              return Container(
                                height: 235,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: (state.crew).map((e) => getShowCards(e)).toList(),
                                ),
                              );
                            }
                            if (state is PersonSliderViewError) {
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
              ),
            ],
          );
        } else {
          return Container(
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
                            "People",
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
                                model: widget.inputModel,
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
                    builder: (context, PersonSliderViewState state) {
                      if (state is PersonSliderViewSuccess) {
                        return Container(
                          height: 235,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: (state.cardModels).map((e) => getShowCards(e)).toList(),
                          ),
                        );
                      }
                      if (state is PersonSliderViewError) {
                        debugPrint(state.error.toString());

                        return InkWell(
                          onTap: () {
                            bloc.add(LoadItemsEvent(widget.inputModel.url));
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
          );
        }
      }),
    );
  }

  Widget getShowCards(PersonCardInputModel model) {
    return Container(
      width: 130,
      padding: EdgeInsets.only(left: 4, right: 4),
      child: PersonCardView(
        inputModel: model,
      ),
    );
  }
}
