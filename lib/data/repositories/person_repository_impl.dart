
import 'package:rick_and_morty_test/core/error/exception.dart';
import 'package:rick_and_morty_test/core/network_info.dart';
import 'package:rick_and_morty_test/data/datasources/person_data_source.dart';
import 'package:rick_and_morty_test/domain/entities/person_entity.dart';
import 'package:rick_and_morty_test/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_test/domain/repositories/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonDataSource personDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl(
      {required this.personDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    try {
      final person = await personDataSource.getAllPersons(page);

      return Right(person);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final person = await personDataSource.searchPerson(query);

        return Right(person);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
