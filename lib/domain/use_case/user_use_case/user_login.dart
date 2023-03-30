import 'package:dartz/dartz.dart';
import 'package:predict_coffee/domain/repositories/domain_repository.dart';
import 'package:predict_coffee/utils/failure.dart';

import '../../../data/models/user_models/user_model.dart';
import '../../entities/user_entity.dart';

class LoginUser {
  final DomainRepository repository;

  LoginUser(this.repository);

  Future<Either<Failure, UserEntity>> execute(UserModel user) {
    return repository.login(user);
  }
}
