import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_test/domain/entities/person_entity.dart';

abstract class PersonSearchState extends Equatable {
  const PersonSearchState();
  @override
  List<Object?> get props => [];
}

class PersonEmpty extends PersonSearchState {}

class PersonSearchLoading extends PersonSearchState {}

class PersonSearchLoaded extends PersonSearchState {
  final List<PersonEntity> persons;

  const PersonSearchLoaded({required this.persons});
}

class PersonSearcherror extends PersonSearchState {
  final String message;

  const PersonSearcherror({required this.message});
  @override
  List<Object?> get props => [message];
}
