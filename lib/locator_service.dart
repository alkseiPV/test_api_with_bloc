import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_and_morty_test/core/network_info.dart';
import 'package:rick_and_morty_test/data/datasources/person_data_source.dart';
import 'package:rick_and_morty_test/data/repositories/person_repository_impl.dart';
import 'package:rick_and_morty_test/domain/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty_test/domain/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty_test/domain/repositories/person_repository.dart';
import 'package:rick_and_morty_test/domain/usecases/get_all_persons.dart';
import 'package:rick_and_morty_test/domain/usecases/search_person.dart';

import 'package:http/http.dart' as http;

final sl = GetIt.instance;

init() {
  sl.registerFactory(() => PersonListCubit(getAllPersons: sl()));
  sl.registerFactory(() => PersonSearchBloc(searchPerson: sl()));
  sl.registerLazySingleton(() => GetAllPersons(sl()));
  sl.registerLazySingleton(() => SearchPerson(sl()));

  sl.registerLazySingleton<PersonRepository>(() => PersonRepositoryImpl(
        personDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<PersonDataSource>(
      () => PersonDataSourceImpl(client: http.Client()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));


  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
