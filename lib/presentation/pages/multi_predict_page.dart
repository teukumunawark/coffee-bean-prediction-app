import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../states_bloc/image_upload_bloc.dart';
import '../widgets/multi_predict_widgets/multi_image_prev.dart';
import '../widgets/multi_predict_widgets/multi_result_prev.dart';
import '../widgets/multi_predict_widgets/mutli_button_section.dart';
import '../widgets/header_widget.dart';

class MultiPredictPage extends StatefulWidget {
  const MultiPredictPage({super.key});

  @override
  State<MultiPredictPage> createState() => _MultiPredictPageState();
}

class _MultiPredictPageState extends State<MultiPredictPage> {
  final MultiImageBloc multiImageBloc = MultiImageBloc();

  @override
  void dispose() {
    multiImageBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Multi Prediction"),
      //   leading: IconButton(
      //     onPressed: () {
      //       context.pushReplacementNamed('home');
      //       context.read<MultiPredictBloc>().reset();
      //     },
      //     icon: const Icon(
      //       Icons.arrow_back_outlined,
      //     ),
      //   ),
      // ),
      body: StreamBuilder<List<XFile>>(
        stream: multiImageBloc.imageStream,
        builder: (context, AsyncSnapshot<List<XFile>> snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final data = snapshot.data;
            return MultiPredictVeiw(
              multiImageBloc: multiImageBloc,
              dataImage: data,
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return MultiPredictVeiw(
            multiImageBloc: multiImageBloc,
            dataImage: const [],
          );
        },
      ),
    );
  }
}

class MultiPredictVeiw extends StatelessWidget {
  const MultiPredictVeiw({
    Key? key,
    this.dataImage,
    required this.multiImageBloc,
  }) : super(key: key);

  final List<XFile>? dataImage;
  final MultiImageBloc multiImageBloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const HeaderWidget(),
          const SizedBox(height: 15),
          MultiImagePrev(multiImageBloc: multiImageBloc, data: dataImage),
          const MultiResultPrev(),
          MultiButtonSection(multiImageBloc: multiImageBloc, data: dataImage),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
