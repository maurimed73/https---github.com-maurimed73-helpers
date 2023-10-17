import 'package:flutter/material.dart';

class Tela01Controller extends ChangeNotifier {
  bool isLoad = false;
  List<String> listaMusica = [];
  bool passwordVisible = false;
  int porcentoSplash = 0;

  void trocarLoad() {
    isLoad = !isLoad;
    notifyListeners();
  }

  void AlterarVisiblePassword() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  void milisegundosSplashScreen(x) {
    porcentoSplash = x;
    notifyListeners();
  }
}
