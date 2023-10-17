import 'package:flutter/material.dart';
import 'package:pesquisa_flutter/CHANGENOTIFIER/tela01_controller.dart';

class Tela01 extends StatefulWidget {
  const Tela01({super.key});

  @override
  State<Tela01> createState() => _Tela01State();
}

class _Tela01State extends State<Tela01> {
  Tela01Controller tela01 = Tela01Controller();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('ChangeNotifier')),
        body: ListenableBuilder(
          listenable: tela01,
          builder: (context, child) => ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'CHANGE NOTIFIER',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                color: Colors.red,
                width: 56,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '1 - Criar Variáveis',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      '2 - Criar Classe para armazenar estado',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      '3 - Extender essa classe -> extends ChangeNotifier',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      '4 - Na classe criar método que altera estado da variável',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      '5 - No final do método colocar o método notifyListeners()',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      '6 - Na View criar instância de estado ex:store',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      '7 - No return antes do Widget colocar o ListenableBuilder',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      '8 - no parâmetro listenable -> colocar a variável store',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      '9 - No Widget color a variável store.nomedométodo',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              Switch(
                // thumb color (round icon)
                activeColor: Colors.amber,
                activeTrackColor: Colors.cyan,
                inactiveThumbColor: Colors.blueGrey.shade600,
                inactiveTrackColor: Colors.grey.shade400,
                splashRadius: 50.0,
                // boolean variable value
                value: tela01.isLoad,
                // changes the state of the switch
                onChanged: (value) {
                  tela01.trocarLoad();
                },
              ),
              tela01.isLoad
                  ? const Center(child: Text('Ligado'))
                  : const Center(child: Text('Desligado')),
            ],
          ),
        ),
      ),
    );
  }
}
