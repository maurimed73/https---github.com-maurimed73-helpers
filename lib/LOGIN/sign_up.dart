import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pesquisa_flutter/LOGIN/login.dart';
import 'package:pesquisa_flutter/LOGIN/login_helper.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpLogin extends StatefulWidget {
  const SignUpLogin({super.key});

  @override
  State<SignUpLogin> createState() => _SignUpLoginState();
}

class _SignUpLoginState extends State<SignUpLogin> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  LoginCtr login = LoginCtr();
  // Insert a new journal to the database
  Future<void> _addItem(nome, senha) async {
    await LoginCtr.createItem(nome, senha);
  }

  TextEditingController usuarioController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController senhaConfirmarController = TextEditingController();
  final String background =
      'https://acdn.mitiendanube.com/stores/925/127/products/7997e6b2-bc84-469e-a851-300e3c96dec21-a684cca70a9a2d30b416753042191383-640-0.jpeg';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                'Criar Login',
                style:
                    GoogleFonts.giveYouGlory(color: Colors.white, fontSize: 30),
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
                      decoration: const InputDecoration(
                        hintText: "Usuário",
                        hintStyle: TextStyle(color: Colors.white70),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entre com a Senha';
                        }
                        return null;
                      },
                      controller: senhaController,
                      obscureText: !_passwordVisible,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Senha",
                        hintStyle: const TextStyle(color: Colors.white70),
                        suffixIcon: IconButton(
                          icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.blue),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entre com a Senha';
                        }
                        return null;
                      },
                      controller: senhaConfirmarController,
                      obscureText: !_passwordVisible,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Confirme Senha",
                        hintStyle: const TextStyle(color: Colors.white70),
                        suffixIcon: IconButton(
                          icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.blue),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (senhaController.text !=
                                senhaConfirmarController.text) {
                              const snackBar = SnackBar(
                                content: Text('Senhas não conferem!'),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              const snackBar = SnackBar(
                                content: Column(
                                  children: [
                                    Text('Senhas Confirmadas!'),
                                    Text('Usuário Cadastrado'),
                                  ],
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              cadastrarLogin(
                                  usuarioController.text, senhaController.text);

                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => TelaLogin(
                                  usuario: usuarioController.text,
                                  senha: senhaController.text,
                                ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Future<bool> cadastrarLogin(String nome, String senha) async {
    final id = _addItem(nome, senha);
    print(id);
    final result = await LoginCtr.getItems();
    print(result);
    return false;
  }
}
