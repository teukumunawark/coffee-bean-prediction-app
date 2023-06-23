import 'package:equatable/equatable.dart';

import '../../domain/entities/coffee_beans_list.dart';
import 'coffee_beans_models.dart';

class CoffeeBeansListModels extends Equatable {
  final List<CoffeeBeansModel> result;

  const CoffeeBeansListModels({required this.result});

  factory CoffeeBeansListModels.fromJson(List<dynamic> json) {
    return CoffeeBeansListModels(
      result: json.map((data) => CoffeeBeansModel.fromJson(data)).toList(),
    );
  }

  CoffeeBeansList toEntity() => CoffeeBeansList(
        result: result.map((e) => e.toEntity()).toList(),
      );

  @override
  List<Object?> get props => [result];
}
