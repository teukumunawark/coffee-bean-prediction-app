import 'package:dartz/dartz.dart';
import '../entities/coffee_beans.dart';

import '../../../core/error/failures.dart';
import '../repositories/repository.dart';

class CreateMultiClassifyCoffeeBean {
  final Repository repository;

  CreateMultiClassifyCoffeeBean(this.repository);

  Future<Either<Failure, List<CoffeeBeans>>> execute(
    List<String> imagePathList,
  ) {
    return repository.makeMultiClassification(imagePathList);
  }
}
