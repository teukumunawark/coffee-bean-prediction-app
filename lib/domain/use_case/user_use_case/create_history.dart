import 'package:dartz/dartz.dart';
import 'package:predict_coffee/domain/repositories/domain_repository.dart';
import 'package:predict_coffee/utils/failure.dart';

import '../../../data/models/single_predict_models/single_predict_models.dart';

class CreateHistory {
  final DomainRepository repository;

  CreateHistory(this.repository);

  Future<Either<Failure, void>> execute(
    List<PredictionModel> prediction,
  ) {
    return repository.createHistory(prediction);
  }
}
