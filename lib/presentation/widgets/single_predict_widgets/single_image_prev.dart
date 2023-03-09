import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constants.dart';
import '../../bloc/image_upload_bloc.dart';
import '../../bloc/single_predict/single_predict_bloc.dart';
import '../button_icon_widget.dart';

class ImagePrevWidget extends StatelessWidget {
  final SingleImageBloc imageBloc;
  final XFile? data;

  const ImagePrevWidget(this.data, this.imageBloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return ImageUploadPreview(data, imageBloc);
  }
}

class ImageUploadPreview extends StatelessWidget {
  final XFile? data;
  final SingleImageBloc imageBloc;
  const ImageUploadPreview(this.data, this.imageBloc, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      width: double.maxFinite,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: data == null
            ? const DecorationImage(
                image: AssetImage('assets/images/img.jpg'),
                fit: BoxFit.cover,
                scale: 1,
                filterQuality: FilterQuality.low,
              )
            : DecorationImage(
                image: FileImage(File(data!.path)),
                fit: BoxFit.cover,
              ),
      ),
      child: BlocBuilder<SinglePredictBloc, SinglePredictState>(
        builder: (context, state) {
          if (state is PredictionHasData) {
            return const ResetButtonSection();
          }

          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: BackdropFilter(
                      filter: data == null
                          ? ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0)
                          : ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        width: double.maxFinite,
                        height: 65,
                        color: data == null ? null : Colors.black12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/img-icon.svg'),
                                    data == null
                                        ? const SizedBox(width: 15)
                                        : const SizedBox(
                                            width: 10,
                                          ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 7),
                                      height: double.maxFinite,
                                      child: data == null
                                          ? Column(
                                              children: [
                                                const Text('support file'),
                                                Text(
                                                  'JPG | PNG',
                                                  style: kBodyText.copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                const Text('support file'),
                                                Text(
                                                  'JPG | PNG',
                                                  style: kBodyText.copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                    )
                                  ],
                                ),
                              ),
                              ButtonIconComponet(
                                buttonRadius: 50,
                                buttonColor:
                                    data == null ? kPrimary : Colors.green,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/choice-img.svg',
                                        color:
                                            data == null ? kBackground : kWhite,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        data == null
                                            ? 'Pilih Gambar'
                                            : 'Gambar Lain',
                                        style: kHeading6.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: data == null
                                              ? kBackground
                                              : kWhite,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  imageBloc.pickImage(ImageSource.gallery);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class ResetButtonSection extends StatelessWidget {
  const ResetButtonSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                height: 290,
                width: double.maxFinite,
                color: Colors.white10,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                      left: 20,
                      right: 20,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          height: 245,
                          padding: const EdgeInsets.all(7),
                          width: double.maxFinite,
                          color: Colors.black12,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              Image.asset(
                                'assets/images/ia-image.png',
                                width: 140,
                              ),
                              const SizedBox(),
                              SizedBox(
                                width: double.maxFinite,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: kSecondery,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<SinglePredictBloc>().reset();
                                    context.pushReplacementNamed('home');
                                  },
                                  child: Text(
                                    "Reset Proses",
                                    style: kHeading5.copyWith(
                                      fontSize: 15,
                                      color: kPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
