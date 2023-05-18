import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/entities/multi_predict_entity.dart';

import '../../../utils/constants.dart';
import '../../states_bloc/image_upload_bloc.dart';
import '../../states_bloc/multi_predict/multi_predict_bloc.dart';
import '../button_icon_widget.dart';

class MultiImagePrev extends StatelessWidget {
  const MultiImagePrev({
    Key? key,
    this.data,
    required this.multiImages,
  }) : super(key: key);

  final List<XFile>? data;
  final MultipleImageUpload multiImages;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultiPredictBloc, MultiPredictState>(
      builder: (context, state) {
        if (state is MultiPredictHasData) {
          final predictData = state.data;

          return MultiImagePrevWidgets(
            data: data,
            predictData: predictData,
            multiImageBloc: multiImages,
          );
        }

        return MultiImagePrevWidgets(
          data: data,
          predictData: const [],
          multiImageBloc: multiImages,
        );
      },
    );
  }
}

class MultiImagePrevWidgets extends StatelessWidget {
  const MultiImagePrevWidgets({
    Key? key,
    required this.data,
    required this.multiImageBloc,
    required this.predictData,
  }) : super(key: key);

  final List<XFile>? data;
  final MultipleImageUpload multiImageBloc;
  final List<List<MultiPredictEntities>> predictData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.only(top: AppSize.marginTop),
      decoration: BoxDecoration(
        color: kSecondery,
        borderRadius: BorderRadius.circular(12),
        image: data!.isEmpty
            ? const DecorationImage(
                image: AssetImage('assets/images/img.jpg'),
                fit: BoxFit.cover,
                scale: 1,
                filterQuality: FilterQuality.low,
              )
            : DecorationImage(
                image: FileImage(File(data![0].path)),
                fit: BoxFit.cover,
              ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black12,
                      Colors.black87,
                    ],
                  )),
            ),
          ),
          data!.isEmpty
              ? ImageUploadButton(
                  title: "Pilih Gambar",
                  multiImageBloc: multiImageBloc,
                  icon: Icons.file_upload_outlined,
                  onPressed: () {
                    multiImageBloc.pickImages(ImageSource.gallery);
                  },
                )
              : ImageUploadButton(
                  title: "Reset Gambar",
                  multiImageBloc: multiImageBloc,
                  icon: Icons.restart_alt_rounded,
                  onPressed: () {
                    context.pushReplacementNamed('home');
                    context.read<MultiPredictBloc>().reset();
                  },
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              margin: const EdgeInsets.only(left: 15, bottom: 15),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  List<XFile> file = [];
                  for (int i = 1; i < data!.length; i++) {
                    file.add(data![i]);
                  }
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 13),
                    decoration: BoxDecoration(
                      color: kBackground,
                      borderRadius: BorderRadius.circular(6),
                      image: data == null
                          ? const DecorationImage(
                              image: AssetImage('assets/images/img.jpg'),
                              fit: BoxFit.cover,
                              scale: 1,
                              filterQuality: FilterQuality.low,
                            )
                          : DecorationImage(
                              image: FileImage(File(file[index].path)),
                              fit: BoxFit.cover,
                            ),
                    ),
                  );
                },
                itemCount: data!.isEmpty ? data!.length : data!.length - 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageUploadButton extends StatelessWidget {
  const ImageUploadButton({
    Key? key,
    required this.multiImageBloc,
    required this.onPressed,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final MultipleImageUpload multiImageBloc;
  final Function() onPressed;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 10),
      child: Align(
        alignment: Alignment.topRight,
        child: ButtonIconComponet(
          buttonRadius: 8,
          onPressed: onPressed,
          child: Container(
            width: 140,
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: kHeading6.copyWith(
                    fontSize: 14,
                    color: kBackground,
                  ),
                ),
                Icon(
                  icon,
                  color: kBackground,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
