import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:ndialog/ndialog.dart';

import '../../utils/constants.dart';
import 'button_widget.dart';

NDialog prosesDialog(BuildContext context, imageBloc) {
  return NDialog(
    dialogStyle: DialogStyle(
      titleDivider: true,
      contentTextStyle: GoogleFonts.poppins(),
    ),
    title: Center(
      child: Text(
        "Kosong".toUpperCase(),
        style: kHeading3,
      ),
    ),
    content: SizedBox(
      height: 210,
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: LottieBuilder.asset(
              'assets/lottie/neurallink.json',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Pilih gambar terlebih dahulu untuk melakukan proses gambar",
            style: kBodyText,
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: ButtonWidget(
          title: "Pilih Gambar",
          borderRadius: 6,
          height: 45,
          onPressed: () {
            Navigator.pop(context);
            imageBloc.pickImage(ImageSource.gallery);
          },
        ),
      ),
    ],
  );
}
