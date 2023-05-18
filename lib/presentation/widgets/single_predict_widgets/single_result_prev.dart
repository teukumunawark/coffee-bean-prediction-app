import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../utils/constants.dart';
import '../../states_bloc/single_predict/single_predict_bloc.dart';

class SingleResultPrev extends StatelessWidget {
  const SingleResultPrev({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SinglePredictBloc, SinglePredictState>(
      builder: (context, state) {
        if (state is PredictionLoading) {
          return const ResultLoading();
        } else if (state is PredictionHasData) {
          final className = state.data[0].className;
          final score = state.data[0].score;
          final calculateScore = score / 100;

          return ResultSection(
            className: className,
            score: score,
            calculateScore: calculateScore,
          );
        } else if (state is PredictionError) {
          return const BackgroundReject();
        }

        return const ResultSection(
          className: null,
          calculateScore: 0,
          score: 0,
        );
      },
    );
  }
}

class ResultLoading extends StatelessWidget {
  const ResultLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xff696767),
            width: 1.5,
          ),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class ResultSection extends StatelessWidget {
  final String? className;
  final double? calculateScore;
  final double? score;

  const ResultSection({
    required this.className,
    required this.calculateScore,
    required this.score,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat('', 'en_US');

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xff696767),
            width: 1.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 140,
              child: CircularPercentIndicator(
                radius: 45,
                percent: calculateScore!.toDouble(),
                lineWidth: 12,
                animation: true,
                animationDuration: 1200,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  "${f.format(score)}%",
                  style: kHeading6,
                ),
                progressColor: kPrimary,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 5),
                  const Text("Hasil Prediksi"),
                  className == null
                      ? Text(
                          'belum ada ...',
                          style: kHeading4.copyWith(fontSize: 24),
                        )
                      : Text(
                          toBeginningOfSentenceCase(className).toString(),
                          style: kHeading3,
                        ),
                  const SizedBox(height: 8),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BackgroundReject extends StatelessWidget {
  const BackgroundReject({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Container(
        height: 130,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          border: Border.all(
            color: const Color(0xff696767),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Penting!!!", style: kHeading6.copyWith(color: kPrimary)),
            const SizedBox(height: 3),
            Text(
              "Gambar ini tidak dapat diproses coba upload gambar lain yang memiliki backgorund berwana putih",
              style: kBodyText.copyWith(),
            ),
            const SizedBox(height: 6)
          ],
        ),
      ),
    );
  }
}
