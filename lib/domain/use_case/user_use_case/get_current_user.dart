import 'package:dartz/dartz.dart';
import '../../entities/user_entity.dart';
import '../../repositories/domain_repository.dart';
import '../../../utils/failure.dart';

class GetCurrentUser {
  final DomainRepository repository;

  GetCurrentUser(this.repository);

  Future<Either<Failure, UserEntity>> execute(String id) {
    return repository.getCurrentUser(id);
  }
}
