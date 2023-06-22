import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../entities/coffee_beans.dart';

abstract class Repository {
  Future<Either<Failure, List<CoffeeBeans>>> makeMultiClassification(
    List<String> imagePathList,
  );
}
