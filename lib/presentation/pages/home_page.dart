import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:predict_coffee/presentation/pages/multi_predict_page.dart';
import 'package:predict_coffee/presentation/pages/single_predict_page.dart';
import 'package:predict_coffee/presentation/states_bloc/multi_predict/multi_predict_bloc.dart';
import 'package:predict_coffee/presentation/states_bloc/single_predict/single_predict_bloc.dart';

import '../../utils/constants.dart';
import '../states_bloc/auth/auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
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
      body: SafeArea(
        child: Stack(
          children: [
            currentIndex == 0
                ? const SinglePredictPage()
                : const MultiPredictPage(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.fromLTRB(
          displayWidth * .05,
          0,
          displayWidth * .05,
          5,
        ),
        height: displayWidth * .155,
        child: ListView.builder(
          itemCount: listOfIcons.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
                HapticFeedback.lightImpact();
                currentIndex == 0
                    ? context.read<SinglePredictBloc>().reset()
                    : context.read<MultiPredictBloc>().reset();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .45
                      : displayWidth * .41,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == currentIndex ? displayWidth * .12 : 0,
                    width: index == currentIndex ? displayWidth * .45 : 0,
                    decoration: BoxDecoration(
                      color: index == currentIndex
                          ? kPrimary.withOpacity(.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .45
                      : displayWidth * .41,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? displayWidth * .13 : 0,
                          ),
                          AnimatedOpacity(
                            opacity: index == currentIndex ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              index == currentIndex ? listOfStrings[index] : '',
                              style: const TextStyle(
                                color: kPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      index != currentIndex
                          ? Center(
                              child: Icon(
                                listOfIcons[index],
                                size: displayWidth * .076,
                                color: index == currentIndex ? kPrimary : kGrey,
                              ),
                            )
                          : Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width: index == currentIndex
                                      ? displayWidth * .03
                                      : 20,
                                ),
                                Icon(
                                  listOfIcons[index],
                                  size: displayWidth * .076,
                                  color:
                                      index == currentIndex ? kPrimary : kGrey,
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.wifi_protected_setup_rounded,
    Icons.wifi_protected_setup_rounded,
  ];

  List child = [
    const SinglePredictPage(),
    const MultiPredictPage(),
  ];

  List<String> listOfStrings = [
    'Single Predict',
    'Multi Predict',
  ];
}
