import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_test/domain/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty_test/domain/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty_test/domain/bloc/search_bloc/search_state.dart';
import 'package:rick_and_morty_test/domain/entities/person_entity.dart';
import 'package:rick_and_morty_test/presentation/widgets/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search for Characters...');

  final _suggestions = ['Rick', 'Morty', '...'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          return close(context, null);
        },
        icon: const Icon(Icons.arrow_back_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    // ignore: avoid_single_cascade_in_expression_statements
    BlocProvider.of<PersonSearchBloc>(context, listen: false)
      ..add(SearchPersons(query));

    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
        builder: (context, state) {
      if (state is PersonSearchLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is PersonSearchLoaded) {
        final person = state.persons;
        if (person.isEmpty) {
          return const Text("ошибкаsd");
        }
        return ListView.builder(
            itemCount: person.isNotEmpty ? person.length : 0,
            itemBuilder: (context, index) {
              PersonEntity result = person[index];
              return SearchResult(personResult: result);
            });
      } else if (state is PersonSearcherror) {
        return const Text("ошибкаssss");
      } else {
        return const Center(
          child: Icon(Icons.now_wallpaper),
        );
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }
    return ListView.separated(
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return Text(
            _suggestions[index],
            style: const TextStyle(fontSize: 16.0),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: _suggestions.length);
  }
}
