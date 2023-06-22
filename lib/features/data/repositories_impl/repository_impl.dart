import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../domain/entities/coffee_beans.dart';
import '../../domain/repositories/repository.dart';
import '../datasources/remote_data_source.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource dataSource;

  RepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<CoffeeBeans>>> makeMultiClassification(
    List<String> imagePathList,
  ) async {
    try {
      final results = await dataSource.makeMultiClassification(imagePathList);
      return Right(results.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on SocketException catch (e) {
      return Left(ConnectionFailure(e.toString()));
    }
  }
}
