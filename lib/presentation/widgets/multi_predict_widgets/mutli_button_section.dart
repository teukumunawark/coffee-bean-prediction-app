import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constants.dart';
import '../../states_bloc/image_upload_bloc.dart';
import '../../states_bloc/multi_predict/multi_predict_bloc.dart';
import '../dialog_widget.dart';

class MultiButtonSection extends StatelessWidget {
  const MultiButtonSection({
    Key? key,
    this.data,
    required this.multiImageBloc,
  }) : super(key: key);

  final List<XFile>? data;
  final MultiImageBloc multiImageBloc;

  @override
  Widget build(BuildContext context) {
    List<String> filePaths = data?.map((file) => file.path).toList() ?? [];

    return BlocBuilder<MultiPredictBloc, MultiPredictState>(
      builder: (context, state) {
        if (state is MultiPredictHasData) {
          final multiData = state.data;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: kSecondery,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Lihat detail dari proses prediksi jenis biji kopi pada halam detail",
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    context.pushNamed('multi-detail', extra: multiData);
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: data!.isEmpty ? kGrey : kPrimary,
                      borderRadius: BorderRadius.circular(6),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: kSecondery,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Silahkan pilih gambar terlebih dahulu untuk bisa melakukan proses upload",
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  data!.isEmpty
                      ? prosesDialog(context, multiImageBloc).show(context)
                      : context
                          .read<MultiPredictBloc>()
                          .add(OnMultiPredictEvent(filePaths));
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: data!.isEmpty ? kGrey : kPrimary,
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
