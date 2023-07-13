import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_near/src/services/auth.dart';
import 'package:share_near/src/utils/auth_utils.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/utils/size_config.dart';
import 'package:share_near/src/views/bottom-nav-bar/bottom_nav_bar_view.dart';
import 'package:share_near/src/views/reset-password/reset_password_view.dart';
import 'package:share_near/src/views/global-components/app_text_form_field.dart';
import 'package:share_near/src/views/global-components/default_button.dart';
import 'package:share_near/src/views/sign-up/sign_up_views.dart';

class LogInViews extends StatefulWidget {
  const LogInViews({super.key});

  @override
  State<LogInViews> createState() => _LogInViewsState();
}

class _LogInViewsState extends State<LogInViews> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _errorMessage;
  bool _isProcessing = false;

  Future<void> logIn() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    } on FirebaseException catch (err) {
      setState(() {
        _errorMessage = err.message;
      });
    }
    appUserEmail = _emailController.text.trim();
    AuthUtils().saveUserData(
      _emailController.text.trim(),
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Log in',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getScreenWidth(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                smallerGap,
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Sign in with Email & Password',
                  textAlign: TextAlign.center,
                ),
                smallerGap,
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      AppTextFormField(
                        label: 'Email',
                        hintText: 'Enter your email',
                        svgIcon: 'assets/icons/Mail.svg',
                        textInputType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (email) {
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email ?? '');
                          if (emailValid) {
                            return null;
                          }
                          return 'Enter valid email';
                        },
                      ),
                      smallerGap,
                      AppTextFormField(
                        label: 'Password',
                        hintText: 'Enter your password',
                        svgIcon: 'assets/icons/Lock.svg',
                        obscure: true,
                        controller: _passwordController,
                        validator: (value) {
                          final bool passwordValid =
                              RegExp(r"^(?=.*[a-zA-Z])(?=.*\d).{5,}$")
                                  .hasMatch(value ?? '');
                          if (passwordValid) {
                            return null;
                          }
                          return 'Enter valid password';
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              Get.to(
                                () => const ForgetPasswordView(),
                                transition: Transition.rightToLeft,
                                duration: const Duration(
                                  milliseconds: 700,
                                ),
                              );
                            },
                            child: const Text('Forget your password?'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      DefaultButton(
                        widget: _isProcessing
                            ? CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: getScreenWidth(3),
                              )
                            : Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: getScreenWidth(18),
                                  color: Colors.white,
                                ),
                              ),
                        press: () async {
                          if ((_formKey.currentState!.validate())) {
                            setState(() {
                              _isProcessing = true;
                            });
                            await logIn();
                            if (_errorMessage == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Welcome back!'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }
                            setState(() {
                              _isProcessing = false;
                            });
                            _errorMessage == null
                                ? Get.off(
                                    () => const BottomNavBarView(),
                                    transition: Transition.zoom,
                                  )
                                // ignore: use_build_context_synchronously
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(_errorMessage.toString()),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                            _errorMessage = null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                biggerGap,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        Get.off(
                          () => const SignUpViews(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(
                            milliseconds: 700,
                          ),
                        );
                      },
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
                smallerGap,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
