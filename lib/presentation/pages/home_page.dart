import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:predict_coffee/presentation/bloc/auth/auth_bloc.dart';

import '../../utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: Drawer(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              final user = state.user;
              return Column(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(color: kBackground),
                    accountName: Text('${user.username}',
                        style: kHeading5.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    accountEmail: Text(user.email,
                        style: kHeading5.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.history_toggle_off_rounded,
                        size: 30,
                      ),
                      title: Text(
                        'Single Predict',
                        style: kHeading6,
                      ),
                      onTap: () {
                        context.pushNamed('single-predict');
                        _scaffoldKey.currentState!.closeDrawer();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.history_toggle_off_rounded,
                        size: 30,
                      ),
                      title: Text(
                        'Multi Predict',
                        style: kHeading6,
                      ),
                      onTap: () {
                        context.pushNamed('multi-predict');
                        _scaffoldKey.currentState!.closeDrawer();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.history_toggle_off_rounded,
                        size: 30,
                      ),
                      title: Text(
                        'History',
                        style: kHeading6,
                      ),
                      onTap: () {
                        context.pushNamed('history');
                        _scaffoldKey.currentState!.closeDrawer();
                      },
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ListTile(
                      trailing: const Icon(
                        Icons.login_outlined,
                        size: 30,
                      ),
                      title: Text(
                        'Log out',
                        style: kHeading6,
                      ),
                      onTap: () {
                        context.go('/login');
                        context.read<AuthBloc>().add(OnLogoutEvent());
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Prediksi Jenis Kopi',
          style: kHeading6,
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      body: SafeArea(child: Column()),
    );
  }
}
