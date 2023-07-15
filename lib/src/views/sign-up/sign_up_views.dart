import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_near/src/services/auth.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/utils/size_config.dart';
import 'package:share_near/src/views/global-components/app_text_form_field.dart';
import 'package:share_near/src/views/global-components/default_button.dart';
import 'package:share_near/src/views/log-in/log_in_views.dart';
import 'package:share_near/src/views/user-details/user_details_view.dart';

class SignUpViews extends StatefulWidget {
  const SignUpViews({super.key});

  @override
  State<SignUpViews> createState() => _SignUpViewsState();
}

class _SignUpViewsState extends State<SignUpViews> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPassController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPassController = TextEditingController();
    _formKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  String? _errorMessage;
  bool _isProcessing = false;

  Future<void> signUp() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    } on FirebaseException catch (err) {
      setState(() {
        _errorMessage = err.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign up',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
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
                  "Register Account",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Complete your details to continue',
                  textAlign: TextAlign.center,
                ),
                smallerGap,
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                              RegExp(r"^(?=.*[a-zA-Z])(?=.*\d).{6,}$")
                                  .hasMatch(value ?? '');
                          if (passwordValid) {
                            return null;
                          }
                          return 'Enter valid password';
                        },
                      ),
                      smallerGap,
                      AppTextFormField(
                        label: 'Confirm Password',
                        hintText: 'Re-enter your password',
                        svgIcon: 'assets/icons/Lock.svg',
                        obscure: true,
                        controller: _confirmPassController,
                        validator: (value) {
                          final bool confirmPassValid =
                              _passwordController.text ==
                                  _confirmPassController.text;
                          if (confirmPassValid) {
                            return null;
                          }
                          return 'Passwords doesn\'t match';
                        },
                      ),
                      smallerGap,
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
                            await signUp();
                            setState(() {
                              _isProcessing = false;
                            });
                            _errorMessage == null
                                ? Get.off(
                                    () => const UserDetailsView(),
                                    transition: Transition.rightToLeft,
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
                smallerGap,
                Text(
                  'By continuing, you accept that you accept \nour terms and conditions.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                biggerGap,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Get.off(
                          () => const LogInViews(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(
                            milliseconds: 700,
                          ),
                        );
                      },
                      child: const Text('Log in'),
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
