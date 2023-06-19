import 'package:equatable/equatable.dart';

class Result extends Equatable {
  final String? name;
  final double? score;

  const Result({
    this.name,
    this.score,
  });

  @override
  List<Object?> get props => [
        name,
        score,
      ];
}
