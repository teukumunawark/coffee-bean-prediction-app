part of 'multi_predict_bloc.dart';

abstract class MultiPredictState extends Equatable {
  const MultiPredictState();

  @override
  List<Object> get props => [];
}

class MultiPredictInitial extends MultiPredictState {}

class MultiPredictLoading extends MultiPredictState {}

class MultiPredictHasError extends MultiPredictState {
  final String message;

  const MultiPredictHasError(this.message);

  @override
  List<Object> get props => [message];
}

class MultiPredictHasData extends MultiPredictState {
  final List<List<MultiPredictEntities>> data;

  const MultiPredictHasData(this.data);

  @override
  List<Object> get props => [data];
}
