import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:camera/camera.dart';
import 'features/presentation/bloc/coffee_beans_bloc.dart';
import 'features/presentation/bloc/multiple_image_capture_bloc.dart';
import 'features/presentation/routes/app_routes.dart';
import 'features/utils/constants.dart';
import 'dependency_injection.dart' as di;

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.setup();

  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<ClassificationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MultipleImageBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Smart Bean',
        theme: ThemeData(
          colorScheme: kColorScheme,
          useMaterial3: true,
          textTheme: kTextTheme,
        ),
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}
