import 'package:dartz/dartz.dart';
import 'package:predict_coffee/domain/repositories/domain_repository.dart';
import 'package:predict_coffee/utils/failure.dart';

import '../../entities/multi_predict_entity.dart';

class CreateMultiPrediction {
  final DomainRepository repository;

  CreateMultiPrediction(this.repository);

  Future<Either<Failure, List<List<MultiPredictEntities>>>> execute(
    List<String> filePath,
  ) {
    return repository.createMultiPredict(filePath);
  }
}
