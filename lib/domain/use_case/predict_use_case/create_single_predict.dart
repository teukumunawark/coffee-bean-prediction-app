import 'package:dartz/dartz.dart';
import 'package:predict_coffee/domain/entities/predict_entity.dart';
import 'package:predict_coffee/domain/repositories/domain_repository.dart';
import 'package:predict_coffee/utils/failure.dart';

class CreateSinglePrediction {
  final DomainRepository repository;

  CreateSinglePrediction(this.repository);

  Future<Either<Failure, List<PredictionEntity>>> execute(String filePath) {
    return repository.createPrediction(filePath);
  }
}
