import 'dart:async';
import 'dart:convert';

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
  PersonDetailBloc() : super(PersonDetailLoading()) {
    on((event, emit) async {
      if (event is LoadPersonDetail) {
        emit.call(PersonDetailLoading());
        final rest = getIt<TMDBService>();

        emit.call(PersonDetailLoading());
        try {
          Response<PersonDetail> response = await rest.getPersonDetail(event.id);

          var body = response.body;
          var stateModel = PersonDetailStateModel(body);

          emit.call(DetailPageLoaded(stateModel));
        } catch (e) {
          emit.call(DetailPageError(e));
        }
      }
    });
  }
}
