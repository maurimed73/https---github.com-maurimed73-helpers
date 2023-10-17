import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

class serviceDir {
  // Todos esses métodos devem ser encapsulados dentro de um
  // bloco try-catch
  // exemplo:

  //final Directory tempDir = await getTemporaryDirectory();
  //final File file = File('${tempDir.path}/sample_file.txt');
  //try{
  //  await file.writeAsString('New content to add');
  //  } catch (e){
  //          handler IO error
  //            }

  obterDiretorio() async {
    //diretório para arquivos de cache
    final temporaryDirectory = await getTemporaryDirectory();

    //diretório para colocar arquivos que não devem ser expostos
    final appSuport = await getApplicationSupportDirectory();

    //diretório para armazenar arquivos gerados pelo usuário
    final appDocuments = await getApplicationDocumentsDirectory();
  }

  //Método para criar um arquivo aleatório no diretório temporário e escrever algo dentro
  CriarEscreverArquivo(String s) async {
    final Directory tempDir = await getTemporaryDirectory();
    final File file = File('${tempDir.path}/sample_file.txt');
    await file.writeAsString('${s}\n', mode: FileMode.append, encoding: utf8);
  }

  //Método para deletar arquivo
  Future<bool> DeletarArquivo() async {
    final Directory tempDir = await getTemporaryDirectory();
    final File file = File('${tempDir.path}/sample_file.txt');
    String dir =
        "/data/user/0/com.example.audio_flutter_internet/cache/sample_file.txt";

    if (File(
            '/data/user/0/com.example.audio_flutter_internet/cache/sample_file.txt')
        .existsSync()) {
      await file.delete().then((value) => null);
      return true;
    } else {
      return false;
    }
  }

  //Criar um novo arquivo em um determinado diretório
  CriarDiretorio_Arquivo() async {
    final Directory tempDir = await getTemporaryDirectory();
    final Directory newDirectory =
        Directory('${tempDir.path}/sample_directory');

    if (await newDirectory.exists() == false) {
      await newDirectory.create();
    }
    final File file = File('${newDirectory.path}/sample_file.txt');
    await file.writeAsString('Sample content to write');
  }

  //Excluir um diretório
  Excluirdiretorio(String s) async {
    final Directory tempDir = await getTemporaryDirectory();
    final Directory newDirectory = Directory('${tempDir.path}/$s');
    await newDirectory.delete(recursive: true);
  }

  //Listar todos os arquivos dentro de um diretório
  ListarArquivos_Diretorio() async {
    final Directory directory = await getTemporaryDirectory();
    final List<FileSystemEntity> files = directory.listSync();

    for (final FileSystemEntity file in files) {
      final FileStat fileStat = await file.stat();
      print('Path: ${file.path}');
      print('Type: ${fileStat.type}');
    }
  }

  //Abrir um arquivo e ver seu conteúdo
  Future<List<String>> AbrirArquivo() async {
    final Directory tempDir = await getTemporaryDirectory();
    final File file = File('${tempDir.path}/sample_file.txt');

    final String fileContent = await file.readAsString();

    //print(fileContent);
    print('#####################################################');
    final List<String> filetext = await file.readAsLines();

    print(filetext.length);
    print(filetext);
    return filetext;
  }

  //Fazer uma cópia do arquivo criado
  copiaArquivo() async {
    final Directory tempDir = await getTemporaryDirectory();
    final File file = File('${tempDir.path}/sample_file.txt');
    final File copy = await file.copy('${tempDir.path}/copy_file.txt');
  }

  //renomear nome do arquivo
  renomearArquivo() async {
    final Directory tempDir = await getTemporaryDirectory();
    final File file = File('${tempDir.path}/new_name');
    await file.rename('${tempDir.path}/new_name.txt');
  }

  //Listar todos os arquivos dentro de um diretório
  DeletarTodosArquivos_Diretorio() async {
    final Directory directory = await getTemporaryDirectory();
    final List<FileSystemEntity> files = directory.listSync();

    for (final FileSystemEntity file in files) {
      await file.delete();
    }
  }
}

Future<List<String>> lista() async {
  final Directory tempDir = await getTemporaryDirectory();
  final File file = File('${tempDir.path}/sample_file.txt');
  print(file);

  final String fileContent = await file.readAsString();

  //print(fileContent);
  //print('#####################################################');
  final List<String> filetext = await file.readAsLines();

  //print(filetext.length);
  //print(filetext);
  return filetext;
}

class Tela05 extends StatefulWidget {
  const Tela05({super.key});

  @override
  State<Tela05> createState() => _Tela05State();
}

class _Tela05State extends State<Tela05> {
  serviceDir service = serviceDir();

  @override
  Widget build(BuildContext context) {
    //TextEditingController textController = TextEditingController();
    TextEditingController _musicaController = TextEditingController();

    String? codeDialog = "";
    String? valueText;
    Future<void> _displayTextInputDialog(BuildContext context) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Digite a Música'),
              content: TextField(
                onChanged: (value) {
                  setState(() {
                    valueText = value;
                  });
                },
                controller: _musicaController,
                decoration: const InputDecoration(hintText: ""),
              ),
              actions: <Widget>[
                MaterialButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  child: const Text('CANCEL'),
                  onPressed: () {
                    if (_musicaController.text.isEmpty) {
                      print('Sair');
                      setState(() {
                        Navigator.pop(context);
                      });
                    }
                  },
                ),
                MaterialButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: const Text('OK'),
                  onPressed: () {
                    setState(() {
                      if (_musicaController.text.isEmpty) {
                        print('Sair');
                        setState(() {
                          Navigator.pop(context);
                        });
                      } else {
                        codeDialog = valueText;
                        Navigator.pop(context);
                      }
                    });
                  },
                ),
              ],
            );
          });
    }

    Future<List<String>> pegarMusicas() async {
      return lista();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Escreve e Lê em arquivo txt',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            //right: (MediaQuery.of(context).size.width - 20) / 2,
            left: 15,
            top: 70,
            child: Container(
              width: 20,
              height: 800,
              color: Colors.amber,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder<List<String>>(
              future: pegarMusicas(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Não há informações'),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Center(
                            child: Text('') //CircularProgressIndicator(),
                            ),
                      ),
                    ],
                  );
                } else {
                  List<String> musicas = snapshot.data!;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text('Músicas sendo adicionadas no Arquivo'),
                        const Center(child: Text('sample_file.txt')),
                        Padding(
                          padding: const EdgeInsets.only(left: 40, top: 30),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: musicas.length,
                              itemBuilder: (context, index) {
                                return Text(musicas[index]);
                              }),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          Positioned(
            bottom: 15,
            right: 100,
            child: FloatingActionButton(
                heroTag: 'btnDelete',
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                elevation: 30,
                child: Icon(Icons.delete),
                onPressed: () async {
                  bool result = await service.DeletarArquivo();
                  result ? setState(() {}) : null;
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'btnAdicionar',
        onPressed: () async {
          _displayTextInputDialog(context).then((value) {
            if (codeDialog != "") {
              service.CriarEscreverArquivo(_musicaController.text);
            }
          });

          //service.DeletarTodosArquivos_Diretorio();
          //await service.CriarEscreverArquivo('Cântico de Salmo'); // não imprime no console
          //service.ListarArquivos_Diretorio();
          //service.AbrirArquivo();
          //service.DeletarArquivo();
          setState(() {});
        },
        tooltip: 'Song Novos',
        child: const Icon(Icons.add),
      ),
    );
  }
}
