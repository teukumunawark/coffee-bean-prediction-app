import 'package:equatable/equatable.dart';

class PredictionEntity extends Equatable {
  final String className;
  final double score;
  final double probability;

  const PredictionEntity({
    required this.className,
    required this.score,
    required this.probability,
  });

  Map<String, dynamic> toMap() {
    return {
      'className': className,
      'score': score,
      'probability': probability,
    };
  }

  @override
  List<Object?> get props => [className, score, probability];
}
