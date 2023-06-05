import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../bloc/multiple_image_capture_bloc.dart';

import '../../utils/constants.dart';
import '../bloc/coffee_beans_bloc.dart';
import '../routes/app_routes.dart';
import '../widgets/button_loading_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/loading_button_widget.dart';
import '../widgets/text_header_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<MultipleImageBloc, MultipleImageState>(
            builder: (context, state) {
              if (state is MultipleImageStateLoaded) {
                return HomeViewWidget(images: state.images);
              } else if (state is MultipleImageLoading) {
                return const LoadImageLoading();
              }
              return const HomeViewWidget(images: []);
            },
          ),
        ),
      ),
    );
  }
}

class HomeViewWidget extends StatelessWidget {
  const HomeViewWidget({super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextHeaderWidget(),
        const SizedBox(height: 15),
        ImagePreviewWidget(images: images),
        const SizedBox(height: 15),
        ImageStatusWidget(images: images),
        const SizedBox(height: 15),
        ButtonSectionWidget(images: images)
      ],
    );
  }
}

class ImagePreviewWidget extends StatelessWidget {
  const ImagePreviewWidget({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: kSecondery,
        borderRadius: BorderRadius.circular(12),
        image: images.isNotEmpty
            ? DecorationImage(
                image: FileImage(File(images.first)),
                fit: BoxFit.cover,
                scale: 1,
              )
            : const DecorationImage(
                image: AssetImage('assets/images/img.jpg'),
                filterQuality: FilterQuality.low,
                fit: BoxFit.cover,
                scale: 1,
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
                  colors: [Colors.black12, Colors.black87],
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton.filled(
              padding: const EdgeInsets.all(12),
              color: images.isNotEmpty ? kWhite : kBackground,
              style: IconButton.styleFrom(
                backgroundColor: images.isNotEmpty ? Colors.red : kPrimary,
              ),
              onPressed: () {
                if (images.isNotEmpty) {
                  context.read<MultipleImageBloc>().add(OnDeletedImage());
                  context.read<ClassificationBloc>().add(OnResetStateEvent());
                } else {
                  context.read<MultipleImageBloc>().add(OnUploadImages());
                }
              },
              icon: Icon(
                images.isNotEmpty ? Icons.close : Icons.add_photo_alternate,
              ),
            ),
          ),
          images.isEmpty
              ? Positioned(
                  top: 10,
                  right: 10 + 55,
                  child: IconButton.filled(
                    padding: const EdgeInsets.all(12),
                    icon: const Icon(Icons.camera_alt_rounded),
                    onPressed: () {
                      router.pushNamed('camera');
                    },
                  ),
                )
              : const SizedBox(),
          if (images.isNotEmpty)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                margin: const EdgeInsets.only(bottom: 15),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 100,
                      margin: const EdgeInsets.only(left: 13),
                      decoration: BoxDecoration(
                        color: kBackground,
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: FileImage(File(images[index + 1])),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  itemCount: images.length - 1,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ImageStatusWidget extends StatelessWidget {
  const ImageStatusWidget({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kSecondery,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<ClassificationBloc, ClassificationState>(
            builder: (context, state) {
              if (state is MultiCoffeeBeansLoaded) {
                return CircularPercentIndicator(
                  radius: 45,
                  percent: 1,
                  lineWidth: 12,
                  animation: true,
                  animationDuration: 1200,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text(
                    "100%",
                    style: kHeading6,
                  ),
                  progressColor: Colors.green,
                );
              }
              return CircularPercentIndicator(
                radius: 45,
                percent: 0,
                lineWidth: 12,
                animation: true,
                animationDuration: 1200,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  "0%",
                  style: kHeading6,
                ),
                progressColor: kPrimary,
              );
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${images.length}",
                    style: kHeading2.copyWith(color: kWhite, fontSize: 45),
                  ),
                  Text(
                    " / Gambar",
                    style: kHeading6.copyWith(height: -3),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              BlocBuilder<ClassificationBloc, ClassificationState>(
                builder: (context, state) {
                  if (state is MultiCoffeeBeansLoaded) {
                    return Text(
                      "Proses berhasil",
                      style: kHeading6.copyWith(
                        height: -0.1,
                        color: Colors.green,
                      ),
                    );
                  }
                  return Text(
                    "Belum diproses",
                    style: kHeading6.copyWith(
                      height: -0.1,
                      color: kPrimary,
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

class ButtonSectionWidget extends StatelessWidget {
  const ButtonSectionWidget({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: kSecondery,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Silahkan pilih gambar terlebih dahulu untuk bisa melakukan proses upload",
            style: kBodyText,
          ),
          const SizedBox(height: 20),
          images.isNotEmpty
              ? BlocBuilder<ClassificationBloc, ClassificationState>(
                  builder: (context, state) {
                  if (state is MultiCoffeeBeansLoaded) {
                    return ButtonWidget(
                      radius: 12,
                      minWidthSize: double.infinity,
                      minHeightSize: 48,
                      color: Colors.green,
                      text: "Cek Detail",
                      textColor: kWhite,
                      onPressed: () {
                        router.pushNamed('detail');
                      },
                    );
                  } else if (state is CoffeeBeansLoading) {
                    return const ButtonLoadingWidget();
                  }
                  return ButtonWidget(
                    radius: 12,
                    minWidthSize: double.infinity,
                    minHeightSize: 48,
                    text: "Clasifikasi",
                    onPressed: () {
                      context
                          .read<ClassificationBloc>()
                          .add(OnMultiScanEvent(images));
                    },
                  );
                })
              : ButtonWidget(
                  radius: 12,
                  minWidthSize: double.infinity,
                  minHeightSize: 48,
                  color: kGrey,
                  textColor: kBackground,
                  text: "Clasifikasi",
                  onPressed: () {},
                )
        ],
      ),
    );
  }
}
