import 'package:dartz/dartz.dart';
import '../../entities/predict_entity.dart';
import '../../repositories/domain_repository.dart';
import '../../../utils/failure.dart';

class CreateSinglePrediction {
  final DomainRepository repository;

  CreateSinglePrediction(this.repository);

  Future<Either<Failure, List<PredictionEntity>>> execute(String filePath) {
    return repository.createPrediction(filePath);
  }
}
