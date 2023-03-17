import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predict_coffee/data/models/single_predict_models/single_predict_models.dart';
import 'package:predict_coffee/domain/entities/predict_entity.dart';
import 'package:predict_coffee/domain/use_case/user_use_case/create_history.dart';
import 'package:predict_coffee/domain/use_case/predict_use_case/create_single_predict.dart';

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

class HistoryBloc extends Bloc<SinglePredictEvent, SinglePredictState> {
  final CreateHistory _createHistory;

  HistoryBloc(this._createHistory) : super(HistoryEmpty()) {
    on<OnCreateHistoryEvent>((event, emit) async {
      final data = event.prediction;
      emit(HistoryHasLoading());
      final result = await _createHistory.execute(data);

      result.fold(
        (failure) => emit(HistoryHasError(failure.message)),
        (_) => emit(HistorySuccess()),
      );
    });

    on<OnGetHistoryEvent>((event, emit) async {});
  }
}
