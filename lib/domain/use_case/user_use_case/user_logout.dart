import 'package:dartz/dartz.dart';
import 'package:predict_coffee/domain/repositories/domain_repository.dart';
import 'package:predict_coffee/utils/failure.dart';

class LogoutUser {
  final DomainRepository repository;

  LogoutUser(this.repository);

  Future<Either<Failure, void>> execute() {
    return repository.logout();
  }
}
