import 'package:flutter/widgets.dart';

import '../../utils/constants.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
    );
  }
}
