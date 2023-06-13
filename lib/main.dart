import 'presentation/states_bloc/single_predict/single_predict_bloc.dart';
import 'presentation/states_bloc/multi_predict/multi_predict_bloc.dart';
import 'presentation/states_bloc/auth/auth_bloc.dart';
import 'utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

import 'injection.dart' as injection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await injection.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => injection.locator<SinglePredictBloc>(),
        ),
        BlocProvider(
          create: (_) => injection.locator<MultiPredictBloc>(),
        ),
        BlocProvider(
          create: (_) => injection.locator<AuthBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Coffee Predict App',
        theme: ThemeData.dark().copyWith(
          primaryColor: kBackground,
          scaffoldBackgroundColor: kBackground,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(background: kBackground),
        ),
        routerConfig: router,
      ),
    );
  }
}
