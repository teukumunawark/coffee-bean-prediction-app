import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_entity.dart';

class UserModel extends Equatable {
  final String? username;
  final String email;
  final String? password;

  const UserModel({
    this.username,
    required this.email,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toMap() => {
        'username': username,
        'email': email,
      };

  UserEntity toEntity() => UserEntity(
        username: username,
        email: email,
      );

  @override
  List<Object?> get props => [
        username,
        email,
        password,
      ];
}
