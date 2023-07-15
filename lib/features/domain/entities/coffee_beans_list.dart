import 'package:equatable/equatable.dart';

import 'coffee_beans.dart';

class CoffeeBeansList extends Equatable {
  final List<CoffeeBeans> result;

  const CoffeeBeansList({required this.result});

  @override
  List<Object?> get props => [result];
}
