import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:weath_app/common/resources/app_assets.dart';
import 'package:weath_app/features/home_screen/presentation/view/home_screen.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/SplashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splashTransition: SplashTransition.fadeTransition,
        splash: Image.asset(
          ImagesAssets.mainLogo,
          width: MediaQuery.of(context).size.width * 0.8,
        ),
        duration: 0,
        centered: true,
        splashIconSize: 210,
        disableNavigation: true,
        nextScreen: const HomeScreen(),
      ),
    );
  }
}
