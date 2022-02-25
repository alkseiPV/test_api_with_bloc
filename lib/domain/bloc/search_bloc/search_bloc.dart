import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_test/domain/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty_test/domain/bloc/search_bloc/search_state.dart';
import 'package:rick_and_morty_test/domain/usecases/search_person.dart';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty()) {
    on<SearchPersons>((event, emit) async {
      emit(PersonSearchLoading());
      final personOrFailure =
          await searchPerson.call(SearchPersonParams(query: event.personQuery));
      emit(personOrFailure.fold(
          (failure) => const PersonSearcherror(message: 'Ошибка'),
          (person) => PersonSearchLoaded(persons: person )));
    });
  }
}
