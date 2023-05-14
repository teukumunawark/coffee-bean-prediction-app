import 'package:equatable/equatable.dart';

import 'multi_predict_models.dart';

class MultiPredictResponse extends Equatable {
  final List<MultiPredictions> list;

  const MultiPredictResponse({required this.list});

  factory MultiPredictResponse.fromJsonList(List<dynamic> json) {
    final List<MultiPredictions> predictions =
        json.map((e) => MultiPredictions.fromJson(e)).toList();
    return MultiPredictResponse(list: predictions);
  }

  @override
  List<Object?> get props => [list];
}
