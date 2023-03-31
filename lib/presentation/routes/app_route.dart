import 'package:go_router/go_router.dart';
import 'package:predict_coffee/presentation/pages/information_page.dart';
import 'package:predict_coffee/presentation/pages/multi_detail_card.dart';
import 'package:predict_coffee/presentation/pages/multi_predict_detail_page.dart';
import 'package:predict_coffee/presentation/pages/single_predict_detail_page.dart';
import 'package:predict_coffee/presentation/pages/home_page.dart';
import 'package:predict_coffee/presentation/pages/login_page.dart';
import 'package:predict_coffee/presentation/pages/multi_predict_page.dart';
import 'package:predict_coffee/presentation/pages/register_page.dart';
import 'package:predict_coffee/presentation/pages/single_predict_page.dart';
import 'package:predict_coffee/presentation/pages/splash_page.dart';
import 'package:predict_coffee/presentation/routes/component_route.dart';

import '../pages/history_page.dart';

final router = GoRouter(
  routes: [
    goRoute(
      name: 'splash',
      path: '/',
      child: const SplashPage(),
    ),
    goRoute(
      name: 'register',
      path: '/register',
      child: const RegisterPage(),
    ),
    goRoute(
      name: 'login',
      path: '/login',
      child: const LoginPage(),
    ),
    goRoute(
      name: 'home',
      path: '/home',
      child: const HomePage(),
    ),
    goRoute(
      name: 'information',
      path: '/information',
      child: const InformationPage(),
    ),
    goRoute(
      name: 'single-predict',
      path: '/single',
      child: const SinglePredictPage(),
    ),
    goRoute(
      name: 'multi-predict',
      path: '/multi',
      child: const MultiPredictPage(),
    ),
    goRoute(
      name: 'history',
      path: '/history',
      child: const HistoryPage(),
    ),
    goRoute(
      name: 'single-detail',
      path: '/single-detail',
      child: const SinglePredictDetailPage(),
    ),
    goRoute(
      name: 'multi-card',
      path: '/multi-card',
      child: const MultiCardDetail(),
    ),
    goRoute(
      name: 'multi-detail',
      path: '/multi-detail',
      child: const MultiPredictDetailPage(),
    ),
  ],
);
