import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:predict_coffee/utils/constants.dart';

import '../states_bloc/auth/auth_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        context.goNamed('login');
      } else {
        context.read<AuthBloc>().add(OnCurrentEvent(user.uid));
        context.pushReplacementNamed('home', extra: user);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DefaultTextStyle(
          style: kHeading2,
          child: AnimatedTextKit(
            pause: const Duration(microseconds: 10),
            isRepeatingAnimation: true,
            animatedTexts: [
              RotateAnimatedText('COFFEE'),
              RotateAnimatedText('BEAN'),
              RotateAnimatedText('PREDICTION'),
            ],
          ),
        ),
      ),
    );
  }
}
