import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/user_models/user_model.dart';
import '../../utils/constants.dart';
import '../states_bloc/auth/auth_bloc.dart';
import '../widgets/auth_widgets/text_field_widget.dart';
import '../widgets/button_loading_widget.dart';
import '../widgets/button_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  final confirmpasswordController = TextEditingController(text: '');

  bool isVisible = false;
  bool isVisibleConfirm = false;

  @override
  Widget build(BuildContext context) {
    Widget headerText() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create account",
              style: kHeading2.copyWith(fontSize: 30),
            ),
            Text(
              "Sign up to get started!",
              style: kHeading6.copyWith(fontSize: 15),
            ),
          ],
        );

    Widget usernameInput() => CustomeTextField(
          controller: usernameController,
          labelText: "Username",
          prefixIcon: const Icon(Icons.person_rounded),
        );

    Widget emailInput() => CustomeTextField(
          controller: emailController,
          labelText: "Email",
          prefixIcon: const Icon(Icons.email_rounded),
        );

    Widget passwordInput() => CustomeTextField(
          controller: passwordController,
          labelText: "Password",
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

    Widget confirmPasswordInput() => CustomeTextField(
          controller: confirmpasswordController,
          labelText: "Confirm password",
          prefixIcon: const Icon(Icons.lock_rounded),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isVisibleConfirm = !isVisibleConfirm;
              });
            },
            icon: !isVisibleConfirm
                ? const Icon(Icons.visibility_off_sharp, color: kGrey)
                : const Icon(Icons.visibility, color: kPrimary),
          ),
          obscureText: !isVisibleConfirm,
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
            if (state is AuthLoading) {
              return Container(
                height: 52,
                decoration: BoxDecoration(
                  color: kPrimary,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Center(child: CircularProgressIndicator()),
              );
            } else if (state is AuthHasError) {
              return ButtonWidget(
                title: 'Login',
                height: 52,
                onPressed: () {
                  hendleRegister(context);
                },
              );
            } else if (state is AuthInitial) {
              return ButtonWidget(
                title: 'Register',
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

    Widget loginTextRoute() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already member?",
              style: kHeading6.copyWith(fontSize: 16),
            ),
            TextButton(
                onPressed: () {
                  context.goNamed('login');
                },
                child: Text(
                  "Log in",
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
              usernameInput(),
              const SizedBox(height: 15),
              emailInput(),
              const SizedBox(height: 15),
              passwordInput(),
              const SizedBox(height: 15),
              confirmPasswordInput(),
              const SizedBox(height: 35),
              buttonSubmit(),
              const Spacer(),
              loginTextRoute(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void hendleRegister(BuildContext context) {
    UserModel userController = UserModel(
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    if (usernameController.text.isEmpty) {
      const snackbar = SnackBar(content: Text('Nama belum di isi'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else if (emailController.text.isEmpty) {
      const snackbar = SnackBar(content: Text('Email belum di isi'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else if (passwordController.text.isEmpty) {
      const snackbar = SnackBar(content: Text('Password belum di isi'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else if (passwordController.text != confirmpasswordController.text) {
      const snackbar = SnackBar(content: Text('Password Tidak Cocok'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      BlocProvider.of<AuthBloc>(context).add(OnRegisterEvent(userController));
    }
  }

  void hendleError(BuildContext context, message) {
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    setState(() {
      usernameController.text = '';
      emailController.text = '';
      passwordController.text = '';
      confirmpasswordController.text = '';
    });
  }
}
