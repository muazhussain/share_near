import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_near/firebase_options.dart';
import 'package:share_near/src/services/auth.dart';
import 'package:share_near/src/utils/size_config.dart';
import 'package:share_near/src/utils/themes.dart';
import 'package:share_near/src/views/bottom-nav-bar/bottom_nav_bar_view.dart';
import 'package:share_near/src/views/splash/splash_view.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ShareNearApp());
}

class ShareNearApp extends StatelessWidget {
  ShareNearApp({super.key});

  final User? user = Auth().currentUser;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: user != null ? const BottomNavBarView() : const SplashView(),
      // home: ProductDetailsView(
      //   product: demoProducts[0],
      // ),
    );
  }
}
