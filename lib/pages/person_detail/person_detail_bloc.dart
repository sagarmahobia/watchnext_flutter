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
  PersonDetailBloc() : super(PersonDetailInitial()) {
    on((e, emit) async {
      if (e is LoadPersonDetail) {
        LoadPersonDetail event = e;
        TMDBService rest = getIt<TMDBService>();

        emit.call(PersonDetailLoading());
        try {
          Response<PersonDetail> response = await rest.getPersonDetail(event.id);

          var stateModel = PersonDetailStateModel(response.body);

          emit.call(DetailPageLoaded(stateModel));
        } catch (e) {
          emit.call(DetailPageError(e));
        }
      }
    });
  }
}
