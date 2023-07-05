import 'package:go_router/go_router.dart';
import '../pages/camera_page.dart';
import '../pages/detail_page.dart';
import '../pages/home_page.dart';
import 'component_route.dart';

final router = GoRouter(
  routes: [
    goRoute(
      name: 'home',
      path: '/',
      child: const HomePage(),
      routes: [
        goRoute(
          name: 'detail',
          path: 'detail',
          child: const DetailPage(),
        ),
        goRoute(
          name: 'camera',
          path: 'camera',
          child: const CameraPage(),
        ),
      ],
    ),
  ],
  initialLocation: '/',
  debugLogDiagnostics: true,
  routerNeglect: true,
);
