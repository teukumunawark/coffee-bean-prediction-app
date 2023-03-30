import 'package:dartz/dartz.dart';
import 'package:predict_coffee/domain/entities/user_entity.dart';
import 'package:predict_coffee/domain/repositories/domain_repository.dart';
import 'package:predict_coffee/utils/failure.dart';

class GetCurrentUser {
  final DomainRepository repository;

  GetCurrentUser(this.repository);

  Future<Either<Failure, UserEntity>> execute(String id) {
    return repository.getCurrentUser(id);
  }
}
