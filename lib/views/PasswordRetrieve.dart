import 'package:biotapajos_app/components/Buttons.dart';
import 'package:biotapajos_app/components/EasyLoading.dart';
import 'package:biotapajos_app/components/Inputs.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/styles/Color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toast/toast.dart';

class PasswordRetrieve extends StatefulWidget {
  @override
  _PasswordRetrieveState createState() => _PasswordRetrieveState();
}

class _PasswordRetrieveState extends State<PasswordRetrieve> {
  TextEditingController _email = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  _retrievePassord() {
    if (_email.text.isNotEmpty) {
      easyLoading();
      _auth.sendPasswordResetEmail(email: _email.text.trim()).then((value) {
        EasyLoading.dismiss();
        Toast.show(S.of(context).emailEnviado, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.pushReplacementNamed(context, '/login');
      }).catchError((error) {
        EasyLoading.dismiss();
        Toast.show(S.of(context).errorEmail, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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
                      S.of(context).recuperarSenha,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0, bottom: 8.0),
                    child: Text(
                      S.of(context).recuperarText,
                      style: TextStyle(color: Colors.white),
                    ),
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
                    padding: const EdgeInsets.only(top: 64.0),
                    child: btLogin(
                      call: () {
                        _retrievePassord();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
