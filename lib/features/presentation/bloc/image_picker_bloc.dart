import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePicker _picker;

  ImagePickerBloc(
    this._picker,
  ) : super(ImagePickerInitial()) {
    on<OnUploadImages>((event, emit) async {
      emit(ImagePickerLoading());

      final List<XFile> images = await _picker.pickMultiImage();

      final List<String> imagePaths = images.map((e) => e.path).toList();

      emit(ImagePickerLoaded(imagePaths));
    });

    on<OnCaptureImage>((event, emit) async {
      final currentState = state;
      List<String> imagePaths = [];

      if (currentState is ImagePickerLoaded) {
        imagePaths = List.from(currentState.images);
      }

      final image = await event.controller.takePicture();
      imagePaths.add(image.path);

      emit(ImagePickerLoaded(imagePaths));
    });

    on<OnDeletedImage>((event, emit) => emit(ImagePickerInitial()));
  }
}
