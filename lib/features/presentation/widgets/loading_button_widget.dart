import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class LoadImageLoading extends StatelessWidget {
  const LoadImageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    width: width * 0.5,
                    decoration: BoxDecoration(
                      color: kSecondery,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 15,
                    decoration: BoxDecoration(
                      color: kSecondery,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 15,
                    width: width * 0.68,
                    decoration: BoxDecoration(
                      color: kSecondery,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
            Container(
              height: height * 0.37,
              decoration: BoxDecoration(
                color: kSecondery,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Stack(
                children: [
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      backgroundColor: kSoftBlack,
                      radius: 25,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10 + 55,
                    child: CircleAvatar(
                      backgroundColor: kSoftBlack,
                      radius: 25,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
            Container(
              height: height * 0.19,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: kSecondery,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CircleAvatar(
                    backgroundColor: kSoftBlack,
                    radius: 45,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: kSoftBlack,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 180,
                        decoration: BoxDecoration(
                          color: kSoftBlack,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
            Container(
              height: height * 0.17,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: kSecondery,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 15,
                    decoration: BoxDecoration(
                      color: kSoftBlack,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 15,
                    width: width * 0.6,
                    decoration: BoxDecoration(
                      color: kSoftBlack,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: kSoftBlack,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     const Center(
    //       child: CircularProgressIndicator(
    //         color: kWhite,
    //       ),
    //     ),
    //     const SizedBox(height: 40),
    //     AnimatedTextKit(
    //       animatedTexts: [
    //         TypewriterAnimatedText(
    //           'Loading...',
    //           textStyle: kHeading4,
    //           speed: const Duration(milliseconds: 100),
    //         ),
    //       ],
    //       totalRepeatCount: 100,
    //       pause: const Duration(milliseconds: 100),
    //     )
    //   ],
    // );
  }
}
