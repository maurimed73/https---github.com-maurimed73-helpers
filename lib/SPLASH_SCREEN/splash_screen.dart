import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pesquisa_flutter/CHANGENOTIFIER/tela01_controller.dart';
import 'package:pesquisa_flutter/LOGIN/login.dart';
import 'package:pesquisa_flutter/widgets/drawer_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool determinate = false;
  int texto = 0;
  // @override
  // void initState() {
  //   super.initState();
  // Timer(Duration(seconds: 300), () {
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => TelaLogin(),
  //       ));
  // });
  // }

  @override
  void initState() {
    efeito();
    Timer(Duration(seconds: 3), () {
      controller = AnimationController(
        /// [AnimationController]s can be created with `vsync: this` because of
        /// [TickerProviderStateMixin].
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {});
      controller.repeat();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DrawerPage(),
        ),
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    controller
        .dispose(); // Dispose of the animation controller when the widget is removed from the tree
    super.dispose();
  }

  Tela01Controller controllerPercento = Tela01Controller();

  @override
  Widget build(BuildContext context) {
    print('começou');
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: Stack(
          children: [
            const Positioned(
              bottom: 40,
              right: 30,
              child: Text(
                'Repositório',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            ListenableBuilder(
              listenable: controllerPercento,
              builder: (context, child) => Center(
                child: Container(
                  child: CircularPercentIndicator(
                    lineWidth: 15.0,
                    animation: true,
                    animationDuration: 2700,
                    percent: 100 / 100,
                    center: Text(
                      '${controllerPercento.porcentoSplash.toString()}%',
                      style: const TextStyle(fontSize: 22),
                    ),
                    footer: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Sincronizando...'),
                        Text(
                          '${controllerPercento.porcentoSplash.toString()}%',
                          style: const TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                    radius: 120,
                    progressColor: Colors.green,
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 120,
              left: 40,
              child: Container(
                child: LinearPercentIndicator(
                  width: 280.0,
                  lineHeight: 15,
                  percent: 100 / 100,
                  animation: true,
                  animationDuration: 2700,
                  progressColor: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void efeito() async {
    for (int x = 1; x <= 100; x++) {
      await Future.delayed(Duration(milliseconds: 15), () {
        texto = x;
        controllerPercento.porcentoSplash = x;
        controllerPercento.milisegundosSplashScreen(x);
      });
    }
  }
}
