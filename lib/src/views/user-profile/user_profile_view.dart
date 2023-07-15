import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_near/src/services/auth.dart';
import 'package:share_near/src/utils/auth_utils.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/utils/size_config.dart';
import 'package:share_near/src/views/global-components/default_button.dart';
import 'package:share_near/src/views/log-in/log_in_views.dart';
import 'package:share_near/src/views/my-products/my_products_view.dart';
import 'package:share_near/src/views/rented-products/rented_products_view.dart';
import 'package:share_near/src/views/upload-product/upload_new_product.dart';
import 'package:share_near/src/views/user-profile/components/profile_picture.dart';
import 'package:share_near/src/views/user-profile/components/user_profile_menu.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  bool _inProcess = false;

  Future<void> signOut() async {
    await AuthUtils().clearData();
    await Auth()
        .userSignOut()
        .whenComplete(() => log('done'))
        .onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          duration: const Duration(seconds: 1),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getScreenWidth(20),
              ),
              child: Column(
                children: <Widget>[
                  smallerGap,
                  const ProfilePicture(),
                  biggerGap,
                  // UserProfileMenu(
                  //   leadingIcon: 'assets/icons/User Icon.svg',
                  //   text: 'My Account',
                  //   press: () {},
                  // ),
                  // smallerGap,
                  UserProfileMenu(
                    leadingIcon: 'assets/icons/product.svg',
                    text: 'Rented Products',
                    press: () {
                      Get.to(
                        () => const RentedProductView(),
                        duration: const Duration(milliseconds: 700),
                        transition: Transition.rightToLeft,
                      );
                    },
                  ),
                  smallerGap,
                  UserProfileMenu(
                    leadingIcon: 'assets/icons/product.svg',
                    text: 'My Products',
                    press: () {
                      Get.to(
                        () => const MyProductsView(),
                        duration: const Duration(milliseconds: 700),
                        transition: Transition.rightToLeft,
                      );
                    },
                  ),
                  smallerGap,
                  UserProfileMenu(
                    leadingIcon: 'assets/icons/product.svg',
                    text: 'Upload a prodoct',
                    press: () {
                      Get.to(
                        () => const UploadNewProduct(),
                        duration: const Duration(milliseconds: 700),
                        transition: Transition.rightToLeft,
                      );
                    },
                  ),
                  smallerGap,
                  UserProfileMenu(
                    leadingIcon: 'assets/icons/nid.svg',
                    text: 'Terms & Conditions',
                    press: () async {
                      final url = Uri.parse('');
                      launchUrl(url, mode: LaunchMode.inAppWebView);
                    },
                  ),
                  biggerGap,
                  DefaultButton(
                    press: () async {
                      _inProcess = true;
                      setState(() {});
                      await signOut();
                      _inProcess = false;
                      Get.off(
                        () => const LogInViews(),
                        duration: const Duration(milliseconds: 700),
                        transition: Transition.downToUp,
                      );
                    },
                    widget: _inProcess
                        ? CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: getScreenWidth(3),
                          )
                        : const Text('Log out'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
