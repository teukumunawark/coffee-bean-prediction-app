import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predict_coffee/domain/entities/user_entity.dart';
import 'package:predict_coffee/domain/use_case/user_use_case/get_current_user.dart';

import '../../../data/models/user_models/user_model.dart';
import '../../../domain/use_case/user_use_case/user_login.dart';
import '../../../domain/use_case/user_use_case/user_logout.dart';
import '../../../domain/use_case/user_use_case/user_register.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUser _register;
  final LoginUser _login;
  final GetCurrentUser _currentUser;
  final LogoutUser _logout;

  AuthBloc(
    this._login,
    this._register,
    this._currentUser,
    this._logout,
  ) : super(AuthInitial()) {
    on<OnRegisterEvent>((event, emit) async {
      final user = event.user;
      emit(AuthLoading());
      final result = await _register.execute(user);

      result.fold(
        (failure) => emit(AuthHasError(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });

    on<OnLoginEvent>((event, emit) async {
      final user = event.user;
      emit(AuthLoading());
      final result = await _login.execute(user);

      result.fold(
        (failure) => emit(AuthHasError(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });

    on<OnCurrentEvent>((event, emit) async {
      final id = event.id;
      emit(AuthLoading());
      final result = await _currentUser.execute(id);

      result.fold(
        (failure) => emit(AuthHasError(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });

    on<OnLogoutEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await _logout.execute();
      result.fold(
        (failure) => emit(AuthHasError(failure.message)),
        (_) => emit(AuthInitial()),
      );
    });
  }
}
