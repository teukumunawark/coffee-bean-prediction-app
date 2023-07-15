import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../bloc/coffee_beans_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/card_widget.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Classifikasi"),
        centerTitle: true,
      ),
      body: BlocBuilder<ClassificationBloc, ClassificationState>(
          builder: (context, state) {
        if (state is MultiCoffeeBeansLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemBuilder: (context, index) {
                final datas = state.dataLoaded[index];

                Uint8List bytes = base64.decode("${datas.image}");

                return CardWidget(datas: datas, bytes: bytes);
              },
              itemCount: state.dataLoaded.length,
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }
}
