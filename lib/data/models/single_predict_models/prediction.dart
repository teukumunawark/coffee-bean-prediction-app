import 'package:equatable/equatable.dart';

import '../../../domain/entities/predict_entity.dart';

class PredictionModel extends Equatable {
  final String className;
  final double score;
  final double probability;

  const PredictionModel({
    required this.className,
    required this.score,
    required this.probability,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) =>
      PredictionModel(
        className: json['class_name'],
        score: json['score'],
        probability: json['probability'],
      );

  Map<String, dynamic> toJson() => {
        'class_name': className,
        'score': score,
        'probability': probability,
      };

  PredictionEntity toEntity() => PredictionEntity(
        className: className,
        score: score,
        probability: probability,
      );

  @override
  List<Object?> get props => [className, score, probability];
}
