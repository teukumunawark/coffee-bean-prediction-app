import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/single_predict_models/single_predict_models.dart';
import '../../../domain/entities/predict_entity.dart';
import '../../../domain/use_case/predict_use_case/create_single_predict.dart';

part 'single_predict_event.dart';
part 'single_predict_state.dart';

class SinglePredictBloc extends Bloc<SinglePredictEvent, SinglePredictState> {
  final CreateSinglePrediction _createSinglePredict;

  SinglePredictBloc(this._createSinglePredict) : super(PredictionEmpty()) {
    on<OnPredictionEvent>(
      (event, emit) async {
        final filePath = event.filePath;
        emit(PredictionLoading());
        final result = await _createSinglePredict.execute(filePath);
        result.fold(
          (failure) => emit(PredictionError(failure.message)),
          (data) => emit(PredictionHasData(data)),
        );
      },
    );
    on<ResetEvent>((event, emit) {
      emit(PredictionEmpty());
    });
  }
  void reset() {
    add(ResetEvent());
  }
}
