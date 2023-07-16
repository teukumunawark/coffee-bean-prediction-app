import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../utils/constants.dart';
import '../bloc/image_picker_bloc.dart';
import '../routes/app_routes.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      cameras[0],
      ResolutionPreset.max,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
      _controller.setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Stack(
        children: [
          cameraPreviewWidget(
            controller: _controller,
            initializeControllerFuture: _initializeControllerFuture,
          ),
          captureControlRowWidget(
            controller: _controller,
            context: context,
            isFlashOn: _isFlashOn,
            toggleFlash: _toggleFlash,
          ),
        ],
      ),
    );
  }
}

PreferredSizeWidget buildAppBar() {
  return AppBar(
    actions: [
      BlocBuilder<ImagePickerBloc, ImagePickerState>(
        builder: (context, state) {
          if (state is ImagePickerLoaded) {
            return ElevatedButton(
              onPressed: () => router.pop(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: kPrimary,
              ),
              child: Row(
                children: [
                  Text(
                    state.images.length.toString(),
                    style: kSubtitle.copyWith(color: kBackground),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Gambar Lanjutkan",
                    style: kSubtitle.copyWith(color: kBackground),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
      const SizedBox(
        width: 15,
      ),
    ],
  );
}

Widget cameraPreviewWidget({
  required Future<void> initializeControllerFuture,
  required CameraController controller,
}) {
  return FutureBuilder<void>(
    future: initializeControllerFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return SizedBox(
          width: double.infinity,
          child: CameraPreview(controller),
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
  );
}

Widget captureControlRowWidget({
  required bool isFlashOn,
  required BuildContext context,
  required Function() toggleFlash,
  required CameraController controller,
}) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      width: double.infinity,
      color: kBackground.withOpacity(0.5),
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 55,
            child: IconButton(
              onPressed: toggleFlash,
              icon: Icon(
                isFlashOn ? Icons.flash_on_outlined : Icons.flash_off_outlined,
                color: kWhite,
                size: 35,
              ),
            ),
          ),
          Container(
            width: 65,
            height: 65,
            decoration: const BoxDecoration(
              color: kPrimary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                context.read<ImagePickerBloc>().add(OnCaptureImage(controller));
              },
              icon: const Icon(
                Icons.camera,
                color: kBackground,
              ),
            ),
          ),
          BlocBuilder<ImagePickerBloc, ImagePickerState>(
            builder: (context, state) {
              if (state is ImagePickerLoaded) {
                return SizedBox(
                  width: 55,
                  height: 55,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(state.images.last),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
              return Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: kSecondery,
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}
