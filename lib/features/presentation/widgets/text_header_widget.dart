import 'package:flutter/widgets.dart';

import '../../utils/constants.dart';

class TextHeaderWidget extends StatelessWidget {
  const TextHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Smart Beans", style: kHeading4),
          const SizedBox(height: 5),
          Text.rich(
            TextSpan(
              text: 'Gambar yang bisa diproses  berupa gambar biji ',
              children: <InlineSpan>[
                TextSpan(
                  text: 'kopi tunggal ',
                  style: kBodyText.copyWith(color: kPrimary),
                ),
                TextSpan(
                  text: 'dengan ',
                  style: kBodyText.copyWith(),
                ),
                TextSpan(
                  text: 'background putih',
                  style: kBodyText.copyWith(color: kPrimary),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
