import 'package:equatable/equatable.dart';

class MultiPredictsEntities extends Equatable {
  final List<List<MultiPredictEntities>> predictEntity;

  const MultiPredictsEntities({required this.predictEntity});

  @override
  List<Object?> get props => [predictEntity];
}

class MultiPredictEntities extends Equatable {
  final String className;
  final double probability;
  final double score;

  const MultiPredictEntities({
    required this.className,
    required this.probability,
    required this.score,
  });

  @override
  List<Object?> get props => [className, probability, score];
}
