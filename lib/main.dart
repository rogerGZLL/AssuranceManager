import 'package:assurance/modules/splash/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
<<<<<<< HEAD
<<<<<<< HEAD
        title: 'Assurance Manager prueba',
=======
        title: 'Assurance Manager_',
>>>>>>> bacf0126f3f8ca278b2cd52cb35f717f2611e60a
=======
        title: 'Assurance Manager prueba',
>>>>>>> Roger
        smartManagement: SmartManagement.keepFactory,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'),
          Locale('es'),
        ],
        home: SplashPage());
  }
}
