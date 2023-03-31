part of 'multi_predict_bloc.dart';

abstract class MultiPredictEvent extends Equatable {
  const MultiPredictEvent();

  @override
  List<Object> get props => [];
}

class OnMultiPredictEvent extends MultiPredictEvent {
  final List<String> filePaths;

  const OnMultiPredictEvent(this.filePaths);

  @override
  List<Object> get props => [filePaths];
}

class ResetEvent extends MultiPredictEvent {}
