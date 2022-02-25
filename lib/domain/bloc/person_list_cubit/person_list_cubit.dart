import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_test/domain/bloc/person_list_cubit/person_list_state.dart';
import 'package:rick_and_morty_test/domain/entities/person_entity.dart';
import 'package:rick_and_morty_test/domain/usecases/get_all_persons.dart';

class PersonListCubit extends Cubit<PersonState> {
  final GetAllPersons getAllPersons;

  PersonListCubit({required this.getAllPersons}) : super(PersonEmpty());
  int page = 1;
  void loadPerson() async {
    if (state is PersonLoading) return;

    final currentState = state;

    var oldPerson = <PersonEntity>[];
    if (currentState is PersonLoaded) {
      oldPerson = currentState.personsList;
    }

    emit(PersonLoading(oldPerson, isFirstFetch: page == 1));

    final failureOrPerson =
        await getAllPersons.call(PagePersonParams(page: page));
    failureOrPerson.fold((error) => PersonError(message: 'ошибка'),
        (character) {
      page++;
       final persons = (state as PersonLoading).oldPersonsList;
       persons.addAll(character);
       // ignore: avoid_print
       print('List length: ${persons.length.toString()}');
       emit(PersonLoaded(persons));
    });
  }
}
