import 'package:equatable/equatable.dart';

import '../../domain/entities/result.dart';

class ResultModel extends Equatable {
  final String? name;
  final double? score;

  const ResultModel({this.name, this.score});

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        name: json['name'] as String?,
        score: (json['score'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'score': score,
      };

  Result toEntity() => Result(name: name, score: score);

  @override
  List<Object?> get props => [name, score];
}
