part of 'image_picker_bloc.dart';

abstract class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();

  @override
  List<Object> get props => [];
}

class OnUploadImages extends ImagePickerEvent {}

class OnCaptureImage extends ImagePickerEvent {
  final CameraController controller;

  const OnCaptureImage(this.controller);

  @override
  List<Object> get props => [controller];
}

class OnDeletedImage extends ImagePickerEvent {}
