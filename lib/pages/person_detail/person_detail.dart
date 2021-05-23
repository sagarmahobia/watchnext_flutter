import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchnext/pages/person_detail/person_detail_bloc.dart';
import 'package:watchnext/views/text_banner/text_banner.dart';

class PersonDetailPage extends StatefulWidget {
  final int id;

  const PersonDetailPage({Key key, this.id}) : super(key: key);

  @override
  _PersonDetailPageState createState() => _PersonDetailPageState(this.id);
}

class _PersonDetailPageState extends State<PersonDetailPage> {
  PersonDetailBloc bloc;

  int id;

  _PersonDetailPageState(this.id);

  @override
  void initState() {
    super.initState();

    bloc = PersonDetailBloc();
    bloc.add(LoadPersonDetail(id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is DetailPageLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(130, 16, 0, 80),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.stateModel.name,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  "Female",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 220,
                          left: 12,
                          child: Image.network(
                            "https://image.tmdb.org/t/p/original" +
                                state.stateModel.profilePath,
                            fit: BoxFit.fitHeight,
                            height: 150,
                            width: 100,
                          ), // or optionally wrap the child in FractionalTranslation
                        )
                      ],
                    ),
                  ),
                  TextBanner(
                    title: "Title",
                    value: "Defjkhdygfuyguyvgduygugfgyyfguyfg",
                  )
                ],
              ),
            );
          } else {
            return Text("Loading");
          }
        },
      ),
    );
  }
}
