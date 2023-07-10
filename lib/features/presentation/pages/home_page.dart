import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../utils/constants.dart';
import '../bloc/coffee_beans_bloc.dart';
import '../bloc/image_picker_bloc.dart';
import '../routes/app_routes.dart';
import '../widgets/button_loading_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/image_upload_widget.dart';
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
          child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
            builder: (context, state) {
              if (state is ImagePickerLoaded) {
                return HomeViewWidget(images: state.images);
              } else if (state is ImagePickerLoading) {
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
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        const TextHeaderWidget(),
        SizedBox(height: height * 0.02),
        imagePreviewWidget(
          images: images,
          height: height * 0.37,
          context: context,
        ),
        SizedBox(height: height * 0.02),
        imageStatusWidget(
          images: images,
          height: height * 0.19,
        ),
        SizedBox(height: height * 0.02),
        buttonSectionWidget(images: images)
      ],
    );
  }
}

Widget imagePreviewWidget({
  required List<String> images,
  required double height,
  required BuildContext context,
}) {
  return Container(
    height: height,
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
        ImageUploadButton(
          top: 10,
          right: 10,
          buttonColor: images.isNotEmpty ? kWhite : kBackground,
          borderColor: images.isNotEmpty ? kWhite : kBackground,
          backgroundColor: images.isNotEmpty ? Colors.red : kPrimary,
          icon: images.isNotEmpty ? Icons.close : Icons.add_photo_alternate,
          onPressed: () {
            if (images.isNotEmpty) {
              context.read<ImagePickerBloc>().add(OnDeletedImage());
              context.read<ClassificationBloc>().add(OnResetStateEvent());
            } else {
              context.read<ImagePickerBloc>().add(OnUploadImages());
            }
          },
        ),
        // Positioned(
        //   top: 10,
        //   right: 10,
        //   child: IconButton.filled(
        //     padding: const EdgeInsets.all(12),
        //     color: images.isNotEmpty ? kWhite : kBackground,
        //     style: IconButton.styleFrom(
        //       elevation: 15,
        //       side: BorderSide(
        //         color: images.isNotEmpty ? kWhite : kBackground,
        //         strokeAlign: BorderSide.strokeAlignCenter,
        //         width: 2,
        //       ),
        //       backgroundColor: images.isNotEmpty ? Colors.red : kPrimary,
        //     ),
        //     onPressed: () {},
        //     icon: Icon(
        //       images.isNotEmpty ? Icons.close : Icons.add_photo_alternate,
        //     ),
        //   ),
        // ),
        images.isEmpty
            ?
            // ? ImageUploadButton(
            //     top: 10,
            //     right: 55 + 10,
            //     buttonColor: images.isNotEmpty ? kWhite : kBackground,
            //     borderColor: images.isNotEmpty ? kWhite : kBackground,
            //     backgroundColor: images.isNotEmpty ? Colors.red : kPrimary,
            //     icon:
            //         images.isNotEmpty ? Icons.close : Icons.add_photo_alternate,
            //     onPressed: () {
            //       if (images.isNotEmpty) {
            //         context.read<ImagePickerBloc>().add(OnDeletedImage());
            //         context.read<ClassificationBloc>().add(OnResetStateEvent());
            //       } else {
            //         router.pushNamed('camera');
            //       }
            //     },
            //   )
            // :
            Positioned(
                top: 10,
                right: 55 + 10,
                child: IconButton.filled(
                  padding: const EdgeInsets.all(12),
                  icon: const Icon(Icons.camera_alt_rounded),
                  onPressed: () {
                    if (images.isNotEmpty) {
                      context.read<ImagePickerBloc>().add(OnDeletedImage());
                      context
                          .read<ClassificationBloc>()
                          .add(OnResetStateEvent());
                    } else {
                      router.pushNamed('camera');
                    }
                  },
                  style: IconButton.styleFrom(
                    elevation: 15,
                    side: const BorderSide(
                      color: kBackground,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      width: 2,
                    ),
                  ),
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
                    margin: EdgeInsets.only(
                      right: 10,
                      left: index == 0 ? 15 : 0,
                    ),
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

Widget imageStatusWidget({
  required List<String> images,
  required double height,
}) {
  return Container(
    height: height,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: kSecondery,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
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
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  "100%",
                  style: kHeading6,
                ),
                progressColor: Colors.green,
              );
            } else if (state is CoffeeBeansLoading) {
              return CircularPercentIndicator(
                radius: 45,
                percent: 1,
                lineWidth: 12,
                animation: true,
                animationDuration: 3500,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  "...",
                  style: kSubtitle.copyWith(color: kPrimary),
                ),
                progressColor: kPrimary,
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
        const SizedBox(width: 20),
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

Widget buttonSectionWidget({required List<String> images}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 15,
    ),
    decoration: BoxDecoration(
      color: kSecondery,
      borderRadius: BorderRadius.circular(12),
    ),
    child: images.isNotEmpty
        ? BlocBuilder<ClassificationBloc, ClassificationState>(
            builder: (context, state) {
            if (state is MultiCoffeeBeansLoaded) {
              return Column(
                children: [
                  Text(
                    "Proses barhasil, silahkan lihat detail yang diproses",
                    style: kBodyText,
                  ),
                  const SizedBox(height: 20),
                  ButtonWidget(
                    radius: 12,
                    minWidthSize: double.infinity,
                    minHeightSize: 48,
                    color: Colors.green,
                    text: "Cek Detail",
                    textColor: kWhite,
                    onPressed: () {
                      router.pushNamed('detail');
                    },
                  ),
                ],
              );
            } else if (state is CoffeeBeansLoading) {
              return Column(
                children: [
                  Text(
                    "Gambar sedang dilakukan klasifikasi tunggu hingga selesai...",
                    style: kBodyText,
                  ),
                  const SizedBox(height: 20),
                  const ButtonLoadingWidget(),
                ],
              );
            }
            return Column(
              children: [
                Text(
                  "Gambar sudah dipilih, coba untuk lakukan klasifikasi ",
                  style: kBodyText,
                ),
                const SizedBox(height: 20),
                ButtonWidget(
                  radius: 12,
                  minWidthSize: double.infinity,
                  minHeightSize: 48,
                  text: "Klasifikasi",
                  onPressed: () {
                    context
                        .read<ClassificationBloc>()
                        .add(OnMultiScanEvent(images));
                  },
                ),
              ],
            );
          })
        : Column(
            children: [
              Text(
                "Silahkan pilih gambar terlebih dahulu untuk bisa melakukan proses upload",
                style: kBodyText,
              ),
              const SizedBox(height: 20),
              ButtonWidget(
                radius: 12,
                minWidthSize: double.infinity,
                minHeightSize: 48,
                color: kGrey,
                textColor: kBackground,
                text: "Clasifikasi",
                onPressed: () {},
              ),
            ],
          ),
  );
}
