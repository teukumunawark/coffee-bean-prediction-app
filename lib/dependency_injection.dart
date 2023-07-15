import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import 'features/data/datasources/remote_data_source.dart';
import 'features/data/repositories_impl/repository_impl.dart';
import 'features/domain/repositories/repository.dart';
import 'features/domain/usecases/create_multi_classify_coffee_beans.dart';
import 'features/presentation/bloc/coffee_beans_bloc.dart';
import 'features/presentation/bloc/image_picker_bloc.dart';

GetIt locator = GetIt.I;

Future<void> setup() async {
  // BLOC STATE INJECTION
  locator.registerFactory(
    () => ClassificationBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => ImagePickerBloc(
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => CreateMultiClassifyCoffeeBean(locator()),
  );

  // REPOSITORY INJECTION
  locator.registerLazySingleton<Repository>(
    () => RepositoryImpl(dataSource: locator()),
  );

  // DATA SOURCE INJECTION
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(dio: locator()),
  );

  // EXTERNAL
  locator.registerLazySingleton(() => Dio());
  locator.registerLazySingleton(() => ImagePicker());
}
