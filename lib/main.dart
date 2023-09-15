import 'package:flutter/material.dart';
import 'package:translator_app/ui/screens/splash_screen.dart';
import 'package:translator_app/ui/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa'),
      ],
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      home: SplashScreen(),
    );
  }
}
