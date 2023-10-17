import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pesquisa_flutter/LOGIN/login.dart';
import 'package:pesquisa_flutter/SPLASH_SCREEN/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuExemplos(),
      //home: SplashScreen(),
    );
  }
}

class MenuExemplos extends StatefulWidget {
  const MenuExemplos({super.key});

  @override
  State<MenuExemplos> createState() => _MenuExemplosState();
}

class _MenuExemplosState extends State<MenuExemplos> {
  //int currentIndex = 0;
  //final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    //return NavigatorBottom();
    return const TelaLogin();
  }
}
