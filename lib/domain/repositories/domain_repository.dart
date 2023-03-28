import 'package:dartz/dartz.dart';

import '../../data/models/single_predict_models/single_predict_models.dart';
import '../../data/models/user_models/user_model.dart';
import '../../utils/failure.dart';
import '../entities/multi_predict_entity.dart';
import '../entities/predict_entity.dart';
import '../entities/user_entity.dart';

abstract class DomainRepository {
  Future<Either<Failure, List<PredictionEntity>>> createPrediction(
    String filePath,
  );
  Future<Either<Failure, List<List<MultiPredictEntities>>>> createMultiPredict(
    List<String> filePaths,
  );
  Future<Either<Failure, UserEntity>> register(UserModel user);
  Future<Either<Failure, UserEntity>> login(UserModel user);
  Future<Either<Failure, UserEntity>> getCurrentUser(String id);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> createHistory(
    List<PredictionModel> prediction,
  );
}
