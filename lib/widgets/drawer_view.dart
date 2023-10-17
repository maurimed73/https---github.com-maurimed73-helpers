import 'package:flutter/material.dart';
import 'package:pesquisa_flutter/ACESSO_GALERIA/tela04.dart';
import 'package:pesquisa_flutter/API/api_page.dart';
import 'package:pesquisa_flutter/CHANGENOTIFIER/tela01.dart';
import 'package:pesquisa_flutter/LOGIN/login.dart';
import 'package:pesquisa_flutter/MOSTRAR_DIRETORIO/tela05.dart';
import 'package:pesquisa_flutter/SQFLITE/tela_02.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  //currentAccountPicture: Image(image: AssetImage('image/musica.jpg')),
                  currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                        'https://static.vecteezy.com/ti/fotos-gratis/t2/8933189-3d-renderizacao-cavalheiro-macho-avatar-com-terno-preto-e-fita-borboleta-vermelha-foto.jpg'),
                  ),
                  accountName: const Text('Mauricio Medeiros'),
                  accountEmail: const Text('maurimed73@gmail.com'),
                ),
                ListTile(
                  leading: const Icon(Icons.account_tree_sharp),
                  title: const Text('ChangeNotifier'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Tela01(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.storage),
                  title: const Text('SQFlite'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Tela02(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.all_inclusive_rounded),
                  title: const Text('API'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Tela03(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image_search),
                  title: const Text('Acesso Galeria'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Tela04(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.file_copy),
                  title: const Text('Listar Diretório'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Tela05(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => TelaLogin(),
                    ));
                  },
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Text('Conteúdos'),
        ),
      ),
    );
  }
}
