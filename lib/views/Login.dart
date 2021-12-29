import 'package:biotapajos_app/components/Buttons.dart';
import 'package:biotapajos_app/components/EasyLoading.dart';
import 'package:biotapajos_app/components/Inputs.dart';
import 'package:biotapajos_app/config/Auth.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/styles/Color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  _login() {
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      easyLoading();
      _auth
          .signInWithEmailAndPassword(
              email: _email.text.trim(), password: _password.text.trim())
          .catchError((error) {
        EasyLoading.dismiss();
        Auth.authError(code: error.code, context: context);
      }).then((value) {
        EasyLoading.dismiss();
        if (value != null) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      });
    } else {
      Toast.show(S.of(context).preenchaCampos, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(child: body()),
    );
  }

  Widget body() {
    return Container(
      child: Column(
        children: [
          Image.asset(
            'images/logo_no_bg.png',
            width: MediaQuery.of(context).size.width * 0.40,
            height: MediaQuery.of(context).size.height * 0.40,
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: PRIMARY,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      S.of(context).entrar,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 32.0, right: 32.0, top: 32.0),
                    child: inputText(
                        controller: _email,
                        hint: S.of(context).email,
                        obscure: false,
                        context: context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 32.0, right: 32.0, top: 16.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        child: Row(
                          children: [
                            Expanded(
                                child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              child: inputTextPass(
                                  controller: _password,
                                  hint: S.of(context).senha,
                                  obscure: _obscureText,
                                  context: context),
                            )),
                            IconButton(
                                onPressed: () {
                                  _toggle();
                                },
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: PRIMARY,
                                ))
                          ],
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 32.0, top: 8.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/retieve');
                          },
                          child: Text(S.of(context).esqueceuSenha,
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  btLogin(call: () {
                    _login();
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).naoTenhoConta,
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            S.of(context).increva,
                            style: TextStyle(color: Colors.black54),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
