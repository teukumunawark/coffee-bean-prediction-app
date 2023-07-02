part of 'coffee_beans_bloc.dart';

abstract class ClassificationState extends Equatable {
  const ClassificationState();

  @override
  List<Object> get props => [];
}

class CoffeeBeansInitial extends ClassificationState {}

class CoffeeBeansLoading extends ClassificationState {}

class CoffeeBeansError extends ClassificationState {
  final String message;

  const CoffeeBeansError(this.message);

  @override
  List<Object> get props => [message];
}

class SingleCoffeeBeansLoaded extends ClassificationState {
  final List<Result> dataLoaded;

  const SingleCoffeeBeansLoaded(this.dataLoaded);

  @override
  List<Object> get props => [dataLoaded];
}

class MultiCoffeeBeansLoaded extends ClassificationState {
  final List<CoffeeBeans> dataLoaded;

  const MultiCoffeeBeansLoaded(this.dataLoaded);

  @override
  List<Object> get props => [dataLoaded];
}
