import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predict_coffee/presentation/bloc/auth/auth_bloc.dart';
import 'package:predict_coffee/presentation/bloc/coffee_bloc.dart';
import 'package:predict_coffee/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'presentation/routes/app_route.dart';
import 'firebase_options.dart';

import 'package:predict_coffee/injection.dart' as injection;

void main() async {
  injection.init();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => injection.locator<PredictBloc>(),
        ),
        BlocProvider(
          create: (_) => injection.locator<AuthBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Coffee Predict App',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kBackground,
          backgroundColor: kBackground,
          scaffoldBackgroundColor: kBackground,
          textTheme: kTextTheme,
        ),
        routerConfig: router,
      ),
    );
  }
}
