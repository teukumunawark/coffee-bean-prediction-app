import 'package:equatable/equatable.dart';
import 'package:predict_coffee/data/models/single_predict_models/prediction.dart';

class SinglePredictModels extends Equatable {
  final List<PredictionModel> predict;

  const SinglePredictModels({required this.predict});

  factory SinglePredictModels.fromJson(Map<String, dynamic> json) =>
      SinglePredictModels(
        predict: List<PredictionModel>.from((json["predictions"] as List)
            .map((x) => PredictionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(predict.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [predict];
}