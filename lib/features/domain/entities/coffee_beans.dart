import 'package:equatable/equatable.dart';

import 'result.dart';

class CoffeeBeans extends Equatable {
  final String? image;
  final List<Result> result;

  const CoffeeBeans({this.image, required this.result});

  @override
  List<Object?> get props => [image, result];
}
