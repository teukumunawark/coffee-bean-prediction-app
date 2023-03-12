import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:predict_coffee/presentation/bloc/single_predict/single_predict_bloc.dart';
import 'package:predict_coffee/presentation/widgets/dialog_widget.dart';
import 'package:predict_coffee/utils/constants.dart';

import '../../bloc/image_upload_bloc.dart';

class ButtonSectionWidget extends StatelessWidget {
  final XFile? dataImage;
  final SingleImageBloc imageBloc;
  const ButtonSectionWidget(this.dataImage, this.imageBloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SinglePredictBloc, SinglePredictState>(
      builder: (context, state) {
        if (state is PredictionHasData) {
          final data = state.data;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            decoration: BoxDecoration(
              color: kSecondery,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                    "Lihat detail dari proses prediksi jenis biji kopi pada halam detail"),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    context.pushNamed('single-detail', extra: data);
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: kPrimary,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Center(
                      child: Text(
                        "Detail",
                        style: kSubtitle.copyWith(
                          color: kBackground,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: kSecondery,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dataImage == null
                    ? "Silahkan pilih gambar terlebih dahulu untuk bisa melakukan proses upload"
                    : "Gambar sudah berhasil di upload ke server silahkan lanjutkan proses",
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  dataImage == null
                      ? prosesDialog(context, imageBloc).show(context)
                      : {
                          context
                              .read<SinglePredictBloc>()
                              .add(OnPredictionEvent(dataImage!.path)),
                        };
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: dataImage == null ? kGrey : kPrimary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      "Proses",
                      style: kSubtitle.copyWith(
                        color: kBackground,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
