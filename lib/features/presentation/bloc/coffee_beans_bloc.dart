import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/coffee_beans.dart';
import '../../domain/entities/result.dart';
import '../../domain/usecases/create_multi_classify_coffee_beans.dart';

part 'coffee_beans_event.dart';
part 'coffee_beans_state.dart';

class ClassificationBloc
    extends Bloc<ClassificationEvent, ClassificationState> {
  final CreateMultiClassifyCoffeeBean _createMultiClassifyCoffeeBean;

  ClassificationBloc(
    this._createMultiClassifyCoffeeBean,
  ) : super(
          CoffeeBeansInitial(),
        ) {
    on<OnMultiScanEvent>((event, emit) async {
      emit(CoffeeBeansLoading());
      final path = event.pathImages;
      final result = await _createMultiClassifyCoffeeBean.execute(path);
      result.fold(
        (failure) => emit(CoffeeBeansError(failure.message)),
        (data) => emit(MultiCoffeeBeansLoaded(data)),
      );
    });

    on<OnResetStateEvent>((event, emit) => emit(CoffeeBeansInitial()));
  }
}
