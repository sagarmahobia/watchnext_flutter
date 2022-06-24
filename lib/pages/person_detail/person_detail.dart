import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchnext/pages/person_detail/person_detail_bloc.dart';
import 'package:watchnext/views/text_banner/text_banner.dart';

class PersonDetailPage extends StatefulWidget {
  final int id;

  const PersonDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _PersonDetailPageState createState() => _PersonDetailPageState();
}

class _PersonDetailPageState extends State<PersonDetailPage> {
  PersonDetailBloc bloc = PersonDetailBloc();

  _PersonDetailPageState();

  @override
  void initState() {
    super.initState();

    bloc.add(LoadPersonDetail(widget.id));
  }

  //todo movie and tv credit

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text("Detail"),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is DetailPageLoaded) {
            DateTime? bday = state.stateModel.personDetail.birthday;
            DateTime? dday = state.stateModel.personDetail.deathday;
            Duration? age;
            if (bday != null) {
              age = (dday ?? DateTime.now()).difference(bday);
            }

            return SingleChildScrollView(
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
                          Image.network(
                            "https://image.tmdb.org/t/p/original" +
                                (state.stateModel.personDetail.profilePath ?? ""),
                            fit: BoxFit.fitHeight,
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
                                    state.stateModel.personDetail.name ?? "N/A",
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      (state.stateModel.personDetail.gender ?? 0) == 1
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
                    value: state.stateModel.personDetail.biography,
                  ),

                  TextBanner(
                    title: "Birthday",
                    value: state.stateModel.personDetail.birthday.toString(),
                  ),

                  TextBanner(
                    title: "Place of Birth",
                    value: state.stateModel.personDetail.placeOfBirth,
                  ),
                  TextBanner(
                    title: "Died",
                    value: state.stateModel.personDetail.deathday != null
                        ? state.stateModel.personDetail.deathday.toString()
                        : null,
                  ),
                  TextBanner(
                    title: "Also Know As",
                    value: state.stateModel.personDetail.alsoKnownAs != null
                        ? state.stateModel.personDetail.alsoKnownAs?.join(", ")
                        : null,
                  ),
                  TextBanner(
                    title: "Known For",
                    value: state.stateModel.personDetail.knownForDepartment,
                  ),
                  TextBanner(
                    title: "Homepage",
                    value: state.stateModel.personDetail.homepage,
                  ),
                  Container(
                    height: MediaQuery.of(context).padding.bottom + 8,
                  )
                ],
              ),
            );
          } else if (state is DetailPageError) {
            return Center(
              child: Text("Something went wrong"),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
