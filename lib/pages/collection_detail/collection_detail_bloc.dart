import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:watchnext/di/injection.dart';
import 'package:watchnext/models/collection_detail.dart';
import 'package:watchnext/services/tmdb_service.dart';

part 'collection_detail_event.dart';

part 'collection_detail_state.dart';

class CollectionDetailBloc extends Bloc<CollectionDetailEvent, CollectionDetailState> {
  CollectionDetailBloc() : super(CollectionDetailLoading()) {
    on<CollectionDetailEvent>((event, emit) async {
      emit.call(CollectionDetailLoading());

      if (event is LoadCollectionDetail) {
        try {
          var response = await (getIt<TMDBService>().getCollection(event.id));

          CollectionDetailModel? body = response.body;

          emit.call(CollectionDetailLoaded(body));
        } catch (e) {
          emit.call(CollectionDetailLoadError());
        }
      }
    });
  }
}
