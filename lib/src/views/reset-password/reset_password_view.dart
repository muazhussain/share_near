import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_near/src/services/auth.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/utils/size_config.dart';
import 'package:share_near/src/views/global-components/app_text_form_field.dart';
import 'package:share_near/src/views/global-components/default_button.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  late final TextEditingController _emailController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _emailController = TextEditingController();
    _formKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _errorMessage;
  bool _isProcessing = false;

  Future<void> resetPassword() async {
    try {
      await Auth().sendPasswordResetEmail(
        email: _emailController.text.trim(),
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
          'Reset password',
          style: TextStyle(color: Colors.black),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
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
                  'Reset Password',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Enter your email to continue',
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
                      DefaultButton(
                        widget: _isProcessing
                            ? CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: getScreenWidth(3),
                              )
                            : Text(
                                'Reset password',
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
                            await resetPassword();
                            // print(_errorMessage);
                            setState(() {
                              _isProcessing = false;
                            });
                            _errorMessage == null
                                // ignore: use_build_context_synchronously
                                ? ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Reset password email sent!',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                // ignore: use_build_context_synchronously
                                : showDialog(
                                    context: context,
                                    builder: (context) => const AlertDialog(
                                      title: Text("Failed"),
                                    ),
                                  );
                            _errorMessage = null;
                          }
                        },
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
}
