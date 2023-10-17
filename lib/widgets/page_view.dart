import 'package:flutter/material.dart';
import 'package:pesquisa_flutter/ACESSO_GALERIA/tela04.dart';
import 'package:pesquisa_flutter/API/api_page.dart';
import 'package:pesquisa_flutter/CHANGENOTIFIER/tela01.dart';
import 'package:pesquisa_flutter/SQFLITE/tela_02.dart';

class NavigatorBottom extends StatefulWidget {
  const NavigatorBottom({super.key});

  @override
  State<NavigatorBottom> createState() => _NavigatorBottomState();
}

class _NavigatorBottomState extends State<NavigatorBottom> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    final pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Conteúdos'),
      ),
      body: PageView(
        physics:
            const NeverScrollableScrollPhysics(), // comando para não deixar rolar com os dedos as páginas
        controller: pageController,
        children: const [
          Tela01(),
          Tela02(),
          Tela03(),
          Tela04(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.teal,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withAlpha(100),
        onTap: (index) {
          setState(() {
            currentIndex = index;
            pageController.jumpToPage(index);
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'ChangeNotifier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'SQFlite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'API',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Arquivo',
          ),
        ],
      ),
    );
  }
}
