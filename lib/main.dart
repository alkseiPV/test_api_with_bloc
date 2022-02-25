import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_test/domain/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty_test/domain/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty_test/locator_service.dart';
import 'package:rick_and_morty_test/presentation/pages/home_page.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonListCubit >(create: (context)=>sl<PersonListCubit>()..loadPerson()),
        BlocProvider<PersonSearchBloc >(create: (context)=>sl<PersonSearchBloc>())
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}