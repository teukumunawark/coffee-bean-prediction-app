import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../domain/entities/coffee_beans.dart';
import '../../utils/constants.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.datas,
    required this.bytes,
  });

  final CoffeeBeans datas;
  final Uint8List bytes;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Card(
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.only(
                left: 16 + 80 + 50,
                bottom: 10,
                top: 10,
                right: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    datas.result[0].name!.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kHeading6,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "SCORE ${datas.result[0].score!.toStringAsFixed(0)}%",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: kHeading6.copyWith(
                      color: kPrimary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 16,
              bottom: 16,
            ),
            child: ClipRRect(
              child: Container(
                width: 120,
                height: 100,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  image: DecorationImage(
                    image: MemoryImage(bytes),
                    fit: BoxFit.cover,
                    scale: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
