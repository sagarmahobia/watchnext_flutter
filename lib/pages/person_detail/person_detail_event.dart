part of 'person_detail_bloc.dart';

@immutable
abstract class PersonDetailEvent {}

class LoadPersonDetail extends PersonDetailEvent {
  final int id;

  LoadPersonDetail(this.id);
}
