part of 'single_predict_bloc.dart';

abstract class SinglePredictState extends Equatable {
  const SinglePredictState();

  @override
  List<Object> get props => [];
}

class ResetEmpty extends SinglePredictState {
  final List data = [];

  ResetEmpty();

  @override
  List<Object> get props => [super.props];
}

// PREDICTION STATE
class PredictionEmpty extends SinglePredictState {}

class PredictionLoading extends SinglePredictState {}

class PredictionError extends SinglePredictState {
  final String message;

  const PredictionError(this.message);

  @override
  List<Object> get props => [message];
}

class PredictionHasData extends SinglePredictState {
  final List<PredictionEntity> data;

  const PredictionHasData(this.data);

  @override
  List<Object> get props => [data];
}

// History State
class HistoryEmpty extends SinglePredictState {}

class HistoryHasLoading extends SinglePredictState {}

class HistoryHasError extends SinglePredictState {
  final String message;

  const HistoryHasError(this.message);

  @override
  List<Object> get props => [message];
}

class HistorySuccess extends SinglePredictState {}
