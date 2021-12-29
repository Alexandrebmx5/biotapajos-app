import 'package:biotapajos_app/components/Buttons.dart';
import 'package:biotapajos_app/components/EasyLoading.dart';
import 'package:biotapajos_app/components/Empty.dart';
import 'package:biotapajos_app/components/Inputs.dart';
import 'package:biotapajos_app/config/Auth.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/styles/Color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _numberPhone = TextEditingController();
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  _setLanguage() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String lang = _sharedPreferences.get('lang');
    setState(() {
      S.load(Locale.fromSubtags(languageCode: lang));
    });
  }

  _createUser() {
    if (_name.text.isNotEmpty &&
        _email.text.isNotEmpty &&
        _password.text.isNotEmpty &&
        _numberPhone.text.isNotEmpty) {
      easyLoading();
      _auth
          .createUserWithEmailAndPassword(
              email: _email.text.trim(), password: _password.text.trim())
          .then((value) {
        value.user.updateProfile(displayName: _name.text.trim());
        Map<String, dynamic> user = {
          "name": _name.text.trim(),
          "email": _email.text.trim(),
          "phone": _numberPhone.text.trim(),
          "url": ""
        };
        _db
            .collection('users')
            .doc(_auth.currentUser.uid)
            .set(user)
            .onError((error, stackTrace) {
          Toast.show(S.of(context).erroCadastro, context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }).then((value) {
          EasyLoading.dismiss();
          Toast.show(S.of(context).usuarioCriado, context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

          Navigator.pushReplacementNamed(context, '/home');
        });
      }).catchError((error) {
        EasyLoading.dismiss();
        Auth.authError(code: error.code, context: context);
      });
    } else {
      Toast.show(S.of(context).preenchaCampos, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: body(),
    );
  }

  Widget body() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 2,
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
                        S.of(context).increva,
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
                          controller: _name,
                          hint: S.of(context).nome,
                          obscure: false,
                          context: context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 32.0, right: 32.0, top: 16.0),
                      child: inputText(
                          controller: _email,
                          hint: S.of(context).email,
                          obscure: false,
                          context: context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 32.0, right: 32.0, top: 16.0),
                      child: inputNumberMask(
                          context: context,
                          controller: _numberPhone,
                          hint: S.of(context).telefone,
                          obscure: false),
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
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: btLogin(call: () {
                        _createUser();
                      }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).tenhoConta,
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Text(
                              S.of(context).entrar,
                              style: TextStyle(color: Colors.black54),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}



/*
 _createUser() {
    if (_name.text.isNotEmpty &&
        _email.text.isNotEmpty &&
        _password.text.isNotEmpty &&
        _numberPhone.text.isNotEmpty) {
      easyLoading();
      _auth
          .createUserWithEmailAndPassword(
              email: _email.text.trim(), password: _password.text.trim())
          .then((value) {
        Map<String, dynamic> user = {
          "name": _name.text.trim(),
          "email": _email.text.trim(),
          "phone": _numberPhone.text.trim()
        };
        _db.collection('users').add(user).onError((error, stackTrace) {
          Toast.show(S.of(context).erroCadastro, context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }).then((value) {
          EasyLoading.dismiss();
          Toast.show(S.of(context).usuarioCriado, context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          Navigator.pushReplacementNamed(context, '/map');
        });
      }).catchError((error) {
        EasyLoading.dismiss();
        Auth.authError(code: error.code, context: context);
      });
    } else {
      Toast.show(S.of(context).preenchaCampos, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

 */
