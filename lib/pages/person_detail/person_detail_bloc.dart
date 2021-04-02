import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';
import 'package:watchnext/di/injection.dart';
import 'package:watchnext/models/person_detail.dart';
import 'package:watchnext/pages/person_detail/person_detail_state_model.dart';
import 'package:watchnext/services/tmdb_service.dart';

part 'person_detail_event.dart';

part 'person_detail_state.dart';

class PersonDetailBloc extends Bloc<PersonDetailEvent, PersonDetailState> {
  PersonDetailBloc() : super(PersonDetailInitial());

  @override
  Stream<PersonDetailState> mapEventToState(
    PersonDetailEvent e,
  ) async* {
    if (e is LoadPersonDetail) {
      LoadPersonDetail event = e;
      TMDBService rest = getIt<TMDBService>();

      yield PersonDetailLoading();
      try {
        Response response = await rest.getPersonDetail(event.id);

        PersonDetail personDetail = personDetailFromJson(response.bodyString);

        var stateModel = PersonDetailStateModel();
        stateModel.profilePath = personDetail.profilePath;
        stateModel.name = personDetail.name;
        yield DetailPageLoaded(stateModel);
      } catch (e) {
        yield DetailPageError(e);
      }
    }
  }
}
