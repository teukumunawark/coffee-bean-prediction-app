import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:predict_coffee/data/api/prediction_api.dart';
import 'package:predict_coffee/data/repositories/data_repository.dart';
import 'package:predict_coffee/data/services/firebase_services.dart';
import 'package:predict_coffee/domain/repositories/domain_repository.dart';
import 'package:predict_coffee/domain/use_case/predict_use_case/create_multi_predict.dart';
import 'package:predict_coffee/domain/use_case/predict_use_case/create_single_predict.dart';
import 'package:predict_coffee/domain/use_case/user_use_case/get_current_user.dart';
import 'package:predict_coffee/presentation/states_bloc/auth/auth_bloc.dart';
import 'package:predict_coffee/presentation/states_bloc/multi_predict/multi_predict_bloc.dart';
import 'package:predict_coffee/presentation/states_bloc/single_predict/single_predict_bloc.dart';
import 'domain/use_case/user_use_case/create_history.dart';
import 'domain/use_case/user_use_case/user_login.dart';
import 'domain/use_case/user_use_case/user_logout.dart';
import 'domain/use_case/user_use_case/user_register.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // BLOC STATE INJECTION
  locator.registerFactory(() => SinglePredictBloc(locator()));
  locator.registerFactory(() => MultiPredictBloc(locator()));
  locator.registerFactory(() => HistoryBloc(locator()));
  locator.registerFactory(
    () => AuthBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // USE CASE INJECTION
  locator.registerLazySingleton(() => CreateSinglePrediction(locator()));
  locator.registerLazySingleton(() => CreateMultiPrediction(locator()));
  locator.registerLazySingleton(() => RegisterUser(locator()));
  locator.registerLazySingleton(() => LoginUser(locator()));
  locator.registerLazySingleton(() => GetCurrentUser(locator()));
  locator.registerLazySingleton(() => LogoutUser(locator()));
  locator.registerLazySingleton(() => CreateHistory(locator()));

  // REPOSITORY INJECTION
  locator.registerLazySingleton<DomainRepository>(
    () => DataRepositoryIMPL(
      dataSource: locator(),
      firebaseDataSource: locator(),
    ),
  );

  // API INJECTION
  locator.registerLazySingleton<ApiDataSource>(
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
