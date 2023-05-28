import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../widgets/auth_widgets/text_field_widget.dart';
import '../widgets/button_widget.dart';
import '../../utils/constants.dart';

import '../../data/models/user_models/user_model.dart';
import '../states_bloc/auth/auth_bloc.dart';
import '../widgets/button_loading_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    Widget headerText() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back",
              style: kHeading2.copyWith(fontSize: 30),
            ),
            Text(
              "Enter your credential to continue",
              style: kHeading6.copyWith(fontSize: 15),
            ),
          ],
        );

    Widget emailInput() => CustomeTextField(
          controller: emailController,
          labelText: 'Email Address',
          prefixIcon: const Icon(Icons.email_rounded),
        );

    Widget passwordInput() => CustomeTextField(
          controller: passwordController,
          labelText: 'Password',
          prefixIcon: const Icon(Icons.lock_rounded),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            icon: !isVisible
                ? const Icon(Icons.visibility_off_sharp, color: kGrey)
                : const Icon(Icons.visibility, color: kPrimary),
          ),
          obscureText: !isVisible,
        );

    buttonSubmit() => BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthHasError) {
              hendleError(context, state.message);
            } else if (state is AuthSuccess) {
              context.pushReplacementNamed('home');
            } else {
              const ButtonLoading();
            }
          },
          builder: (context, state) {
            if (state is AuthInitial) {
              return ButtonWidget(
                title: 'Login',
                height: 52,
                onPressed: () {
                  hendleRegister(context);
                },
              );
            } else if (state is AuthLoading) {
              return const ButtonLoading();
            } else if (state is AuthHasError) {
              return ButtonWidget(
                title: 'Login',
                height: 52,
                onPressed: () {
                  hendleRegister(context);
                },
              );
            }
            return const Center(
              child: Text('Something is wrong'),
            );
          },
        );

    Widget registerTextRoute() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don’t have account?",
              style: kHeading6.copyWith(fontSize: 16),
            ),
            TextButton(
                onPressed: () {
                  context.goNamed('register');
                },
                child: Text(
                  "Sign up",
                  style: kHeading6.copyWith(fontSize: 16),
                ))
          ],
        );

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(elevation: 0),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerText(),
              const SizedBox(height: 40),
              emailInput(),
              const SizedBox(height: 15),
              passwordInput(),
              const SizedBox(height: 35),
              buttonSubmit(),
              const Spacer(),
              registerTextRoute(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void hendleRegister(BuildContext context) {
    UserModel userController = UserModel(
      email: emailController.text,
      password: passwordController.text,
    );

    if (emailController.text.isEmpty) {
      const snackbar = SnackBar(content: Text('Email belum di isi'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else if (passwordController.text.isEmpty) {
      const snackbar = SnackBar(content: Text('Password belum di isi'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      BlocProvider.of<AuthBloc>(context).add(OnLoginEvent(userController));
    }
  }

  void hendleError(BuildContext context, message) {
    if (message ==
        '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
      const snackbar = SnackBar(
        content: Text('password salah coba masukan ulang'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      setState(() {
        passwordController.text = '';
      });
    } else if (message ==
        '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
      const snackbar = SnackBar(
        content: Text('email tidak ditemukan atau anda salah masukan email'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      setState(() {
        emailController.text = '';
      });
    } else {
      final snackbar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      setState(() {
        emailController.text = '';
        passwordController.text = '';
      });
    }
  }
}
