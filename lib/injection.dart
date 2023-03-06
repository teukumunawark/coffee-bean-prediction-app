import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:predict_coffee/data/api/coffee_api.dart';
import 'package:predict_coffee/data/repositories/data_repository.dart';
import 'package:predict_coffee/data/services/firebase_services.dart';
import 'package:predict_coffee/domain/repositories/domain_repository.dart';
import 'package:predict_coffee/domain/use_case/create_prediction.dart';
import 'package:predict_coffee/domain/use_case/get_current_user.dart';
import 'package:predict_coffee/domain/use_case/user_logout.dart';
import 'package:predict_coffee/domain/use_case/user_register.dart';
import 'package:predict_coffee/presentation/bloc/auth/auth_bloc.dart';
import 'package:predict_coffee/presentation/bloc/coffee_bloc.dart';

import 'domain/use_case/user_login.dart';

final locator = GetIt.instance;

void init() {
  // STATE INJECTION
  locator.registerFactory(() => PredictBloc(locator()));
  locator.registerFactory(
    () => AuthBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // USE CASE INJECTION
  locator.registerLazySingleton(() => CreatePrediction(locator()));
  locator.registerLazySingleton(() => RegisterUser(locator()));
  locator.registerLazySingleton(() => LoginUser(locator()));
  locator.registerLazySingleton(() => GetCurrentUser(locator()));
  locator.registerLazySingleton(() => LogoutUser(locator()));

  // REPOSITORY INJECTION
  locator.registerLazySingleton<DomainRepository>(
    () => DataRepositoryIMPL(
      dataSource: locator(),
      firebaseDataSource: locator(),
    ),
  );

  // API INJECTION
  locator.registerLazySingleton<CoffeeDataSource>(
    () => CoffeeDataSourceIMPL(dio: locator()),
  );

  // FIREBASE INJECTION
  locator.registerLazySingleton<FirebaseDataSource>(
    () => FirebaseDataSourceIMPL(auth: locator(), firestore: locator()),
  );

  // EXTERNAL
  locator.registerLazySingleton(() => Dio());
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
}
