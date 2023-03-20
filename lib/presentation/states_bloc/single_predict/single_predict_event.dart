part of 'single_predict_bloc.dart';

abstract class SinglePredictEvent extends Equatable {
  const SinglePredictEvent();

  @override
  List<Object> get props => [];
}

class OnPredictionEvent extends SinglePredictEvent {
  final String filePath;

  const OnPredictionEvent(this.filePath);

  @override
  List<Object> get props => [filePath];
}

class ResetEvent extends SinglePredictEvent {}

// History Event
class OnCreateHistoryEvent extends SinglePredictEvent {
  final List<PredictionModel> prediction;

  const OnCreateHistoryEvent(this.prediction);

  @override
  List<Object> get props => [prediction];
}

class OnGetHistoryEvent extends SinglePredictEvent {
  final List<PredictionEntity> prediction;

  const OnGetHistoryEvent(this.prediction);

  @override
  List<Object> get props => [prediction];
}
