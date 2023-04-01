import 'package:flutter/material.dart';
import 'package:predict_coffee/utils/constants.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    String titleApp = (ModalRoute.of(context)?.settings.arguments as String);
    return Scaffold(
      appBar: AppBar(
        title: Text(titleApp),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final title = titleInformation[index];
            final data = information[titleApp]?[index];

            return Column(
              children: [
                const SizedBox(height: 15),
                Text(
                  title,
                  style: kHeading5.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  data.toString(),
                  style: kBodyText.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 5),
                const Divider(color: kGrey),
              ],
            );
          },
          itemCount: information[titleApp]?.length,
        ),
      ),
    );
  }
}

final titleInformation = [
  "Bentuk",
  "Rasa",
  "Aroma",
  "Keasaman",
  "Kafein",
  "Kromosom",
];

final information = {
  "Premium": [
    "Biji kopi Premium memiliki bentuk yang seragam dan bulat, dengan ukuran yang lebih besar dan padat dibandingkan dengan biji kopi biasa. Hal ini dapat mempengaruhi proses pengolahan biji kopi dan menciptakan cita rasa yang unik.",
    "Biji kopi Premium memiliki cita rasa yang khas dan kompleks, dengan karakteristik yang bergantung pada jenis biji kopi, metode pengolahan, dan tempat tumbuhnya. Secara umum, biji kopi Premium cenderung memiliki rasa yang lebih halus, kaya, dan kompleks dibandingkan dengan biji kopi biasa.",
    "Biji kopi Premium memiliki aroma yang khas dan menarik, dengan karakteristik yang juga bergantung pada jenis biji kopi, metode pengolahan, dan tempat tumbuhnya. Beberapa aroma yang dapat dijumpai pada biji kopi Premium antara lain aroma buah-buahan, coklat, karamel, atau rempah-rempah.",
    "Biji kopi Premium cenderung memiliki tingkat keasaman yang seimbang dan menyegarkan, dengan karakteristik yang juga tergantung pada jenis biji kopi, metode pengolahan, dan tempat tumbuhnya. Beberapa biji kopi Premium memiliki keasaman yang lebih tinggi, seperti biji kopi Arabika, sedangkan beberapa biji kopi Premium memiliki keasaman yang lebih rendah, seperti biji kopi Robusta.",
    "Biji kopi Premium biasanya memiliki kandungan kafein yang moderat, dengan kadar yang berkisar antara 1,2-1,5% dari berat biji kopi. Namun, kadar kafein pada biji kopi Premium juga tergantung pada jenis biji kopi dan tempat tumbuhnya.",
    "Biji kopi Premium tidak memiliki kromosom yang berbeda dari biji kopi biasa, karena semua jenis biji kopi termasuk dalam satu spesies yaitu Coffea arabica atau Coffea robusta. Namun, terdapat variasi genetik yang dapat mempengaruhi kualitas dan karakteristik biji kopi, seperti jenis kultivar atau varietas yang digunakan dan teknik persilangan yang dilakukan."
  ],
  "Peaberry": [
    "Biji kopi Peaberry memiliki bentuk yang unik dan bulat, dengan satu biji kopi dalam satu buah kopi. Hal ini terjadi ketika hanya satu dari dua biji kopi yang ada di dalam buah kopi yang terbentuk, sehingga menghasilkan biji kopi yang lebih bulat dan padat.",
    "Biji kopi Peaberry memiliki cita rasa yang khas dan berbeda dari biji kopi biasa, dengan karakteristik yang bergantung pada jenis biji kopi, metode pengolahan, dan tempat tumbuhnya. Secara umum, biji kopi Peaberry cenderung memiliki rasa yang lebih lembut, manis, dan ringan, dengan asam yang lembut dan tanin yang rendah.",
    "Biji kopi Peaberry memiliki aroma yang khas dan menarik, dengan karakteristik yang juga tergantung pada jenis biji kopi, metode pengolahan, dan tempat tumbuhnya. Beberapa aroma yang dapat dijumpai pada biji kopi Peaberry antara lain aroma buah-buahan, bunga, atau coklat.",
    "Biji kopi Peaberry biasanya memiliki tingkat keasaman yang seimbang, dengan karakteristik yang tergantung pada jenis biji kopi, metode pengolahan, dan tempat tumbuhnya. Beberapa biji kopi Peaberry memiliki keasaman yang lebih tinggi, seperti biji kopi Arabika, sedangkan beberapa biji kopi Peaberry memiliki keasaman yang lebih rendah, seperti biji kopi Robusta.",
    "Biji kopi Peaberry memiliki kandungan kafein yang moderat, dengan kadar yang berkisar antara 1,2-1,5% dari berat biji kopi. Namun, kadar kafein pada biji kopi Peaberry juga tergantung pada jenis biji kopi dan tempat tumbuhnya.",
    "Biji kopi Peaberry tidak memiliki kromosom yang berbeda dari biji kopi biasa, karena semua jenis biji kopi termasuk dalam satu spesies yaitu Coffea arabica atau Coffea robusta. Namun, terdapat variasi genetik yang dapat mempengaruhi kualitas dan karakteristik biji kopi, seperti jenis kultivar atau varietas yang digunakan dan teknik persilangan yang dilakukan."
  ],
  "Longberry": [
    "Biji kopi Longberry memiliki bentuk yang lebih panjang dan ramping dari biji kopi biasa, dengan ukuran yang lebih besar. Hal ini terjadi karena biji kopi Longberry tumbuh hanya dalam satu bagian buah kopi yang panjang, sehingga memungkinkan biji kopi untuk tumbuh lebih besar dan ramping.",
    "Biji kopi Longberry memiliki cita rasa yang khas dan berbeda dari biji kopi biasa, dengan karakteristik yang tergantung pada jenis biji kopi, metode pengolahan, dan tempat tumbuhnya. Secara umum, biji kopi Longberry cenderung memiliki rasa yang lebih halus, dengan asam yang seimbang, rasa manis, dan aroma bunga atau buah-buahan.",
    "Biji kopi Longberry memiliki aroma yang khas dan menarik, dengan karakteristik yang juga tergantung pada jenis biji kopi, metode pengolahan, dan tempat tumbuhnya. Beberapa aroma yang dapat dijumpai pada biji kopi Longberry antara lain aroma bunga, buah-buahan, atau rempah-rempah.",
    "Biji kopi Longberry biasanya memiliki tingkat keasaman yang seimbang, dengan karakteristik yang tergantung pada jenis biji kopi, metode pengolahan, dan tempat tumbuhnya. Beberapa biji kopi Longberry memiliki keasaman yang lebih tinggi, seperti biji kopi Arabika, sedangkan beberapa biji kopi Longberry memiliki keasaman yang lebih rendah, seperti biji kopi Robusta.",
    "Biji kopi Longberry memiliki kandungan kafein yang moderat, dengan kadar yang berkisar antara 1,2-1,5% dari berat biji kopi. Namun, kadar kafein pada biji kopi Longberry juga tergantung pada jenis biji kopi dan tempat tumbuhnya.",
    "Biji kopi Longberry tidak memiliki kromosom yang berbeda dari biji kopi biasa, karena semua jenis biji kopi termasuk dalam satu spesies yaitu Coffea arabica atau Coffea robusta. Namun, terdapat variasi genetik yang dapat mempengaruhi kualitas dan karakteristik biji kopi, seperti jenis kultivar atau varietas yang digunakan dan teknik persilangan yang dilakukan."
  ],
  "Defect": [
    "Biji kopi Defect dapat memiliki berbagai bentuk yang tidak teratur dan tidak seragam. Bentuk yang tidak teratur dapat terjadi karena cacat atau kerusakan pada biji kopi, seperti biji kopi yang retak, berlubang, atau cacat fisik lainnya.",
    "Biji kopi Defect dapat memiliki cita rasa yang kurang baik atau bahkan tidak enak, tergantung pada jenis cacat yang terjadi pada biji kopi tersebut. Beberapa cacat pada biji kopi yang dapat mempengaruhi rasa antara lain biji kopi yang terlalu masak, biji kopi yang terkena hama, atau biji kopi yang terkontaminasi dengan bahan kimia.",
    "Biji kopi Defect dapat memiliki aroma yang tidak sedap atau bahkan tidak memiliki aroma sama sekali. Beberapa cacat pada biji kopi dapat mempengaruhi aroma, seperti biji kopi yang terkontaminasi dengan bahan kimia atau biji kopi yang terlalu lama disimpan.",
    "Biji kopi Defect dapat memiliki tingkat keasaman yang tidak seimbang atau bahkan tidak ada keasaman sama sekali. Beberapa cacat pada biji kopi dapat mempengaruhi keasaman, seperti biji kopi yang terlalu masak atau biji kopi yang terlalu lama disimpan.",
    "Biji kopi Defect dapat memiliki kandungan kafein yang bervariasi tergantung pada jenis cacat yang terjadi pada biji kopi. Namun, secara umum, biji kopi Defect cenderung memiliki kadar kafein yang lebih rendah dibandingkan biji kopi yang sehat.",
    "Biji kopi Defect tidak memiliki kromosom yang berbeda dari biji kopi biasa, karena semua jenis biji kopi termasuk dalam satu spesies yaitu Coffea arabica atau Coffea robusta. Namun, cacat atau kerusakan pada biji kopi dapat terjadi karena faktor genetik, lingkungan, atau proses pengolahan yang kurang baik."
  ]
};
