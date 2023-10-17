import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pesquisa_flutter/CHANGENOTIFIER/tela01_controller.dart';
import 'package:pesquisa_flutter/LOGIN/login_helper.dart';
import 'package:pesquisa_flutter/LOGIN/sign_up.dart';
import 'package:pesquisa_flutter/SPLASH_SCREEN/splash_screen.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key, this.usuario, this.senha});
  final String? usuario;
  final String? senha;

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  LoginCtr login = LoginCtr();
  // Insert a new journal to the database
  Future<void> _addItem(nome, senha) async {
    await LoginCtr.createItem(nome, senha);
  }

  TextEditingController usuarioController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  Tela01Controller controllerObscure = Tela01Controller();

  final String background =
      'https://acdn.mitiendanube.com/stores/925/127/products/7997e6b2-bc84-469e-a851-300e3c96dec21-a684cca70a9a2d30b416753042191383-640-0.jpeg';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    widget.usuario != null
        ? usuarioController.text = widget.usuario!
        : usuarioController.text = "";

    widget.senha != null
        ? senhaController.text = widget.senha!
        : senhaController.text = "";

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(background),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          color: Colors.black.withOpacity(0.9),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                'Seja Bem Vindo',
                style:
                    GoogleFonts.giveYouGlory(color: Colors.white, fontSize: 30),
              ),
              const Text(
                'Preencha para continuar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entre com o Usuário';
                        }
                        return null;
                      },
                      controller: usuarioController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            usuarioController.clear();
                          },
                          icon: Icon(Icons.clear),
                        ),
                        hintText: "Nome de Usuário",
                        hintStyle: const TextStyle(color: Colors.white70),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListenableBuilder(
                      listenable: controllerObscure,
                      builder: (BuildContext context, Widget? child) {
                        return TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Entre com a Senha';
                            }
                            return null;
                          },
                          controller: senhaController,
                          obscureText: controllerObscure.passwordVisible,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: const TextStyle(color: Colors.white70),
                            suffixIcon: SizedBox(
                              width: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      senhaController.clear();
                                    },
                                    icon: const Icon(Icons.clear),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                        controllerObscure.passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.blue),
                                    onPressed: () {
                                      controllerObscure
                                          .AlterarVisiblePassword();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white54),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      child: const Text(
                        'Esqueceu sua Senha?',
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool resultado = await verificarLogin(
                                usuarioController.text, senhaController.text);
                            if (resultado) {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => const SplashScreen(),
                              ));
                            }
                          } else {
                            const snackBar = SnackBar(
                              content: Text('Defina usuario e Senha!'),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Text(
                          'Sign in'.toUpperCase(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Não possui uma conta?',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpLogin(),
                            ));
                            print('criar cliente');
                          },
                          child: const Text(
                            'SIGN UP',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Future<bool> verificarLogin(String nome, String senha) async {
    //_addItem(nome, senha);
    final result = await LoginCtr.getItem(nome, senha);
    if (result.isNotEmpty) {
      return true;
    } else {
      const snackBar = SnackBar(
        content: Text('Informações Inválidas!'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return false;
    }
  }
}
