import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:predict_coffee/domain/use_case/predict_use_case/create_multi_predict.dart';

import '../../../domain/entities/multi_predict_entity.dart';

part 'multi_predict_event.dart';
part 'multi_predict_state.dart';

class MultiPredictBloc extends Bloc<MultiPredictEvent, MultiPredictState> {
  final CreateMultiPrediction _createMultiPredict;

  MultiPredictBloc(this._createMultiPredict) : super(MultiPredictInitial()) {
    on<OnMultiPredictEvent>((event, emit) async {
      final filePaths = event.filePaths;

      emit(MultiPredictLoading());

      final result = await _createMultiPredict.execute(filePaths);

      result.fold(
        (failure) => emit(MultiPredictHasError(failure.message)),
        (data) => emit(MultiPredictHasData(data)),
      );
    });
    on<ResetEvent>((event, emit) {
      emit(MultiPredictInitial());
    });
  }
  void reset() {
    add(ResetEvent());
  }
}
