// adicionar dependências no pubspec
// # dio:
// # path_provider
// # permission_handler
// # image_gallery_saver

// adicionar permissões no Android/app/src/main/AndroidManifest.xml logo abaixo do <manifest xmlns.....
// # <uses-permission android:name="android.permission.INTERNET"/>
// # <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
// dentro do <application  colocar a linha -> android:requestLegacyExternalStorage="true"

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class Tela04 extends StatefulWidget {
  const Tela04({super.key});

  @override
  State<Tela04> createState() => _Tela04State();
}

class _Tela04State extends State<Tela04> {
  bool loading = false;
  double progress = 0;
  final Dio dio = Dio();
  // pede permissão para acessar os arquivos internos no celular
  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  // quando clica no Download Video abre esse método
  dowloadFile() async {
    setState(() {
      loading = true;
    });

    bool downloaded = await saveFile(
        "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
        "video.mp4");
    if (downloaded) {
      print('File Downloaded');
    } else {
      print('Problem Downloading File');
    }

    setState(() {
      loading = false;
    });
  }

  // dependencia do image_picker
  XFile? image;

  // salvar o  arquivo no diretório
  Future<bool> saveFile(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory() as Directory;
          print("primeiro caminho${directory.path}");
          String newPath = '';
          List<String> folders = directory.path.split('/');
          for (int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/BugaApp";
          directory = Directory(newPath);
          print("segundo caminho${directory.path}");
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.storage)) {
          directory = await getTemporaryDirectory();
          print('Este é o diretório $directory');
        } else {
          return false;
        }
      }
      if (!await directory.exists()) {
        directory.create(recursive: true);
      }
      if (await directory.exists()) {
        File saveFile = File("${directory.path}/$fileName");
        await dio.download(url, saveFile.path,
            onReceiveProgress: (downloaded, totalSize) {
          setState(() {
            progress = downloaded / totalSize;
          });
        });

        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Importar Arquivo Galeria',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(Icons.attach_file),
              title: const Text('Buscar foto da Galeria'),
              onTap: selecionarMusica,
              trailing: image != null ? Image.file(File(image!.path)) : null,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 300,
              child: loading
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 10,
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        dowloadFile();
                      },
                      child: const Text('Download Video'),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void selecionarImagen() async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);

      if (file != null) {
        setState(() {
          image = file;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}

void selecionarMusica() async {
  final ImagePicker picker = ImagePicker();
  try {
    XFile? file = await picker.pickMedia();

    if (file != null) {
      String musica = file.name;
      String musicaEnd = file.path;
      print(musica.toString());
      print(musicaEnd);

      // setState(() {
      //   image = file;
      // });
    }
  } catch (e) {
    print(e);
  }
}
