import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_test/domain/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty_test/domain/bloc/person_list_cubit/person_list_state.dart';
import 'package:rick_and_morty_test/domain/entities/person_entity.dart';
import 'package:rick_and_morty_test/presentation/widgets/person_card_widget.dart';

class PersonsList extends StatelessWidget {
  final scrollController = ScrollController();

   PersonsList({Key? key}) : super(key: key);

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<PersonListCubit>().loadPerson();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return BlocBuilder<PersonListCubit, PersonState>(
      builder: (context, state) {
        List<PersonEntity> persons = [];
        bool isloading = false;
        if (state is PersonLoading && state.isFirstFetch) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PersonLoading) {
          persons = state.oldPersonsList;
          isloading = true;
        } else if (state is PersonLoaded) {
          persons = state.personsList;
        }

        return ListView.separated(
            controller: scrollController,
            itemBuilder: (context, index) {
              if(index< persons.length){
                return PersonCard(person: persons[index]);
              }else{
                return const Center(child: CircularProgressIndicator());
              }
              
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.grey,
              );
            },
            itemCount: persons.length + (isloading ? 1 : 0));
      },
    );
  }
}
