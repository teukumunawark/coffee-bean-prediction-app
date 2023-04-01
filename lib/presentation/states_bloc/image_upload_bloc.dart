import 'dart:async';

import 'package:image_picker/image_picker.dart';

class SingleImageBloc {
  final _imageController = StreamController<XFile>();
  Stream<XFile> get imageStream => _imageController.stream;

  void pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile == null) return;
      final XFile file = XFile(pickedFile.path);

      _imageController.sink.add(file);
    } catch (e) {
      // Handle any exceptions thrown by the image picker
      return;
    }
  }

  void dispose() {
    _imageController.close();
  }
}

class MultiImageBloc {
  final _imageController = StreamController<List<XFile>>();
  Stream<List<XFile>> get imageStream => _imageController.stream;
  final List<XFile> _selectedImages = [];

  void pickImages(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final pickedFiles = await picker.pickMultiImage();

      if (pickedFiles == null) return;
      _selectedImages.clear();
      _selectedImages.addAll(pickedFiles);

      _imageController.sink.add(_selectedImages);
    } catch (e) {
      return;
    }
  }

  void dispose() {
    _imageController.close();
  }
}
