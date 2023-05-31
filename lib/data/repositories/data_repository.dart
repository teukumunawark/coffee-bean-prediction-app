import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_services.dart';
import '../../domain/entities/multi_predict_entity.dart';
import '../../domain/entities/predict_entity.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/domain_repository.dart';
import '../../utils/failure.dart';

import '../../utils/exception.dart';
import '../api/prediction_api.dart';
import '../models/user_models/user_model.dart';

class DataRepositoryIMPL implements DomainRepository {
  final ApiDataSource dataSource;
  final FirebaseDataSource firebaseDataSource;

  DataRepositoryIMPL({
    required this.dataSource,
    required this.firebaseDataSource,
  });

  @override
  Future<Either<Failure, List<PredictionEntity>>> createPrediction(
    String filePath,
  ) async {
    try {
      final result = await dataSource.createSinglePredict(filePath);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<List<MultiPredictEntities>>>> createMultiPredict(
    List<String> filePaths,
  ) async {
    try {
      final result = await dataSource.createMultiPredict(filePaths);
      return Right(
        result.map((e) => e.map((r) => r.toEntity()).toList()).toList(),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(UserModel user) async {
    try {
      final result = await firebaseDataSource.register(user);
      return Right(result.toEntity());
    } on FirebaseException {
      return const Left(FirebaseFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(UserModel user) async {
    try {
      final result = await firebaseDataSource.login(user);
      return Right(result.toEntity());
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure('$e'));
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure('$e'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser(String id) async {
    try {
      final result = await firebaseDataSource.getCurrentUser(id);
      return Right(result.toEntity());
    } on FirebaseAuthException {
      return const Left(FirebaseFailure(''));
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure('$e'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result = await firebaseDataSource.logout();
      return Right(result);
    } on FirebaseAuthException {
      return const Left(FirebaseFailure(''));
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure('$e'));
    }
  }
}
