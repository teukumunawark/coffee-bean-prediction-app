part of 'image_picker_bloc.dart';

abstract class ImagePickerState extends Equatable {
  const ImagePickerState();

  @override
  List<Object> get props => [];
}

class ImagePickerInitial extends ImagePickerState {}

class ImagePickerLoading extends ImagePickerState {}

class ImagePickerLoaded extends ImagePickerState {
  final List<String> images;

  const ImagePickerLoaded(this.images);

  @override
  List<Object> get props => [images];
}

class CaptureImageLoaded extends ImagePickerState {
  final String image;

  const CaptureImageLoaded(this.image);

  @override
  List<Object> get props => [image];
}
