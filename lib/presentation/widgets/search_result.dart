import 'package:flutter/material.dart';
import 'package:rick_and_morty_test/domain/entities/person_entity.dart';

class SearchResult extends StatelessWidget {
  final PersonEntity personResult;

  const SearchResult({Key? key, required this.personResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2.0,
      child: Column(
        children: [Text(personResult.name)],
      ),
    );
  }
}
