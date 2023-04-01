import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../states_bloc/image_upload_bloc.dart';
import '../widgets/single_predict_widgets/single_button_section.dart';
import '../widgets/header_widget.dart';
import '../widgets/single_predict_widgets/single_image_prev.dart';
import '../widgets/single_predict_widgets/single_result_prev.dart';

class SinglePredictPage extends StatefulWidget {
  const SinglePredictPage({super.key});

  @override
  State<SinglePredictPage> createState() => _SinglePredictPageState();
}

class _SinglePredictPageState extends State<SinglePredictPage> {
  final SingleImageBloc imageBloc = SingleImageBloc();

  @override
  void dispose() {
    imageBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Single Prediction"),
      //   leading: IconButton(
      //     onPressed: () {
      //       context.pushReplacementNamed('home');
      //       context.read<SinglePredictBloc>().reset();
      //     },
      //     icon: const Icon(
      //       Icons.arrow_back_outlined,
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: StreamBuilder<XFile>(
          stream: imageBloc.imageStream,
          builder: (context, AsyncSnapshot<XFile> snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              return SinglePredictView(dataImage: data, imageBloc: imageBloc);
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            return SinglePredictView(dataImage: null, imageBloc: imageBloc);
          },
        ),
      ),
    );
  }
}

class SinglePredictView extends StatelessWidget {
  const SinglePredictView({
    Key? key,
    required this.dataImage,
    required this.imageBloc,
  }) : super(key: key);

  final XFile? dataImage;
  final SingleImageBloc imageBloc;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        const HeaderWidget(),
        const SizedBox(height: 15),
        ImagePrevWidget(dataImage, imageBloc),
        const SingleResultPrev(),
        ButtonSectionWidget(dataImage, imageBloc),
        const SizedBox(height: 10),
      ],
    );
  }
}
