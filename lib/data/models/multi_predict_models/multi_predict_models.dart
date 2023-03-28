import 'package:equatable/equatable.dart';

import '../../../domain/entities/multi_predict_entity.dart';

class MultiPredictions extends Equatable {
  final List<MultiPrediction> prediction;

  const MultiPredictions({required this.prediction});

  factory MultiPredictions.fromJson(Map<String, dynamic> json) {
    final predictionsJson = json['prediction'] as List<dynamic>;
    final predictions = predictionsJson
        .map((e) => MultiPrediction.fromJson(e as Map<String, dynamic>))
        .toList();
    return MultiPredictions(prediction: predictions);
  }

  MultiPredictsEntities toEntity() => MultiPredictsEntities(
      predictEntity: prediction as List<List<MultiPredictEntities>>);

  @override
  List<Object?> get props => [prediction];
}

class MultiPrediction extends Equatable {
  final String className;
  final double probability;
  final double score;

  const MultiPrediction({
    required this.className,
    required this.probability,
    required this.score,
  });

  factory MultiPrediction.fromJson(Map<String, dynamic> json) {
    return MultiPrediction(
      className: json['class_name'],
      probability: json['probability'] as double,
      score: json['score'] as double,
    );
  }

  MultiPredictEntities toEntity() => MultiPredictEntities(
        className: className,
        probability: probability,
        score: score,
      );

  @override
  List<Object?> get props => [className, probability, score];
}
