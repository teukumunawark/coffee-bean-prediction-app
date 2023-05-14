import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:predict_coffee/utils/constants.dart';

import '../../domain/entities/multi_predict_entity.dart';

class MultiPredictDetailPage extends StatelessWidget {
  const MultiPredictDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<List<MultiPredictEntities>> data = (ModalRoute.of(context)
        ?.settings
        .arguments as List<List<MultiPredictEntities>>);

    var f = NumberFormat('', 'en_US');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Multi Prediction"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final predictData = data[index].map((e) => e);
            return Container(
              height: 150,
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: kSecondery,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: predictData
                        .map(
                          (data) => Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: f.format(data.score),
                                  style: kHeading4.copyWith(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2),
                                  children: [
                                    TextSpan(
                                      text: '%',
                                      style: kBodyText.copyWith(
                                        fontSize: 14,
                                        color: kPrimary,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                toBeginningOfSentenceCase(
                                  data.className,
                                ).toString(),
                                style: kHeading5.copyWith(fontSize: 14),
                              )
                            ],
                          ),
                        )
                        .toList(),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 115,
                      child: ElevatedButton(
                        onPressed: () {
                          context.pushNamed('multi-card', extra: predictData);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(left: 12, right: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Read more"),
                            Icon(Icons.arrow_forward_rounded)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
          itemCount: data.length,
        ),
      ),
    );
  }
}
