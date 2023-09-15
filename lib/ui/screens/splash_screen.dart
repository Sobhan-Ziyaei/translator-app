import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:translator_app/gen/assets.gen.dart';
import 'package:translator_app/ui/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: EasySplashScreen(
        title: Text('مترجم آنلاین متون', style: theme.textTheme.labelMedium),
        backgroundColor: Colors.white,
        logo: Assets.images.logo.image(),
        showLoader: true,
        loaderColor: Colors.blue,
        loadingText: Text(
          '... در حال دریافت اطلاعات ',
          style: theme.textTheme.labelSmall,
        ),
        durationInSeconds: 3,
        navigator: const MainScreen(),
      ),
    );
  }
}
