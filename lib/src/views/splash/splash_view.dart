import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_near/src/utils/size_config.dart';
import 'package:share_near/src/views/global-components/default_button.dart';
import 'package:share_near/src/views/sign-up/sign_up_views.dart';
import 'package:share_near/src/views/splash/components/splash_content.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  List<Map<String, String>> splashData = [
    {
      'text': 'Discover, connect, and share with ShareNear',
      'imagePath': 'assets/images/splash_1.png'
    },
    {
      'text': 'Unlock a world of convenience and community',
      'imagePath': 'assets/images/splash_2.png'
    },
    {
      'text': 'Share Things Share Happiness',
      'imagePath': 'assets/images/splash_3.png'
    },
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              const Spacer(),
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    currentPage = value;
                    setState(() {});
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    text: splashData[index]['text']!,
                    imagePath: splashData[index]['imagePath']!,
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              currentPage == 2
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getScreenWidth(20),
                      ),
                      child: DefaultButton(
                        widget: Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: getScreenWidth(18),
                            color: Colors.white,
                          ),
                        ),
                        press: () {
                          Get.off(
                            () => const SignUpViews(),
                            // () => const SignUpViews(),
                            transition: Transition.downToUp,
                            duration: const Duration(
                              milliseconds: 800,
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
