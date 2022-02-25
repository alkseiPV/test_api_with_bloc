import 'dart:convert';

import 'package:rick_and_morty_test/core/error/exception.dart';
import 'package:rick_and_morty_test/data/models/person_model.dart';
import 'package:http/http.dart' as http;

abstract class PersonDataSource {
  Future<List<PersonModel>> getAllPersons(int page);
  Future<List<PersonModel>> searchPerson(String query);
}

class PersonDataSourceImpl implements PersonDataSource {
  final http.Client client;

  PersonDataSourceImpl({required this.client});
  @override
  Future<List<PersonModel>> getAllPersons(int page) async {
    final response = await client.get(
        Uri.parse("https://rickandmortyapi.com/api/character?page=$page"),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PersonModel>> searchPerson(String query) async  {
    final response = await client.get(
        Uri.parse("https://rickandmortyapi.com/api/character/?name=$query"),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
