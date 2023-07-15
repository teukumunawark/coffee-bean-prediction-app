part of 'coffee_beans_bloc.dart';

abstract class ClassificationEvent extends Equatable {
  const ClassificationEvent();

  @override
  List<Object> get props => [];
}

class OnSingleScanEvent extends ClassificationEvent {
  final String pathImage;

  const OnSingleScanEvent(this.pathImage);

  @override
  List<Object> get props => [pathImage];
}

class OnMultiScanEvent extends ClassificationEvent {
  final List<String> pathImages;

  const OnMultiScanEvent(this.pathImages);

  @override
  List<Object> get props => [pathImages];
}

class OnResetStateEvent extends ClassificationEvent {}
