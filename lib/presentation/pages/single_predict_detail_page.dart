import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:predict_coffee/domain/entities/predict_entity.dart';
import 'package:predict_coffee/presentation/widgets/probabilitas_chart.dart';
import 'package:predict_coffee/utils/constants.dart';

import '../routes/app_route.dart';

class SinglePredictDetailPage extends StatelessWidget {
  const SinglePredictDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<PredictionEntity> data =
        (ModalRoute.of(context)?.settings.arguments as List<PredictionEntity>);

    var f = NumberFormat('', 'en_US');

    final title = toBeginningOfSentenceCase(data[0].className).toString();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/detail-img.jpg',
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 20, right: 20),
              children: [
                Text(
                  "Jenis",
                  style: kHeading5,
                ),
                Text(
                  toBeginningOfSentenceCase(data[0].className).toString(),
                  style: kHeading2.copyWith(height: 1.1),
                ),
                Text.rich(
                  TextSpan(
                    text: f.format(data[0].score),
                    style: kHeading2.copyWith(
                      fontSize: 120,
                      height: 1.2,
                      leadingDistribution: TextLeadingDistribution.proportional,
                    ),
                    children: [
                      TextSpan(
                        text: '%',
                        style: kBodyText.copyWith(
                            fontSize: 45,
                            color: kPrimary,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    router.pushNamed('information', extra: title);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 55,
                      width: 195,
                      padding:
                          const EdgeInsets.only(top: 3, left: 10, right: 10),
                      decoration: const BoxDecoration(
                        color: kPrimary,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Lihat informasi",
                            style: kHeading6.copyWith(
                                fontSize: 16,
                                color: kBackground,
                                fontWeight: FontWeight.w400),
                          ),
                          SvgPicture.asset('assets/images/arrow-up.svg')
                        ],
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: Colors.black26,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: data
                                .skip(1)
                                .map(
                                  (e) => MoreItem(
                                    title: e.className,
                                    score: e.score,
                                  ),
                                )
                                .toList(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 240,
              width: double.maxFinite,
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
              decoration: const BoxDecoration(
                color: kBackground,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(45),
                ),
              ),
              child: probabilitasChart(
                [
                  data[0].className,
                  data[1].className,
                  data[2].className,
                  data[3].className,
                ],
                [
                  [
                    data[0].probability,
                    data[1].probability,
                    data[2].probability,
                    data[3].probability,
                  ]
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MoreItem extends StatelessWidget {
  const MoreItem({
    Key? key,
    required this.score,
    required this.title,
  }) : super(key: key);

  final double score;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              text: score.toString(),
              style: kHeading4.copyWith(
                  fontSize: 35, fontWeight: FontWeight.w500, height: 1.2),
              children: [
                TextSpan(
                  text: '%',
                  style: kBodyText.copyWith(
                    fontSize: 19,
                    color: kPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Text(
            toBeginningOfSentenceCase(title).toString(),
            style: kHeading5.copyWith(fontSize: 16),
          )
        ],
      ),
    );
  }
}
