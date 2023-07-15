import 'package:equatable/equatable.dart';

import '../../domain/entities/coffee_beans.dart';
import 'result_model.dart';

class CoffeeBeansModel extends Equatable {
  final String? image;
  final List<ResultModel> result;

  const CoffeeBeansModel({this.image, required this.result});

  factory CoffeeBeansModel.fromJson(Map<String, dynamic> json) {
    return CoffeeBeansModel(
      image: json['image'] as String?,
      result: (json['result'] as List<dynamic>)
          .map((data) => ResultModel.fromJson(data as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'image': image,
        'result': result.map((e) => e.toJson()).toList(),
      };

  CoffeeBeans toEntity() => CoffeeBeans(
        result: result.map((e) => e.toEntity()).toList(),
        image: image,
      );

  @override
  List<Object?> get props => [image, result];
}
