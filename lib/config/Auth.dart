import 'package:biotapajos_app/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

class Auth {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static isLoged() {
    if (_auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  static authError({@required String code, @required context}) {
    switch (code) {
      case 'email-already-in-use':
        Toast.show(S.of(context).emailEmUso, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        break;
      case 'weak-password':
        Toast.show(S.of(context).senhaFraca, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        break;
      case 'invalid-email':
        Toast.show(S.of(context).emailInvalido, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        break;
      case 'user-not-found':
        Toast.show(S.of(context).emailSenhaErrado, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        break;
      case 'wrong-password':
        Toast.show(S.of(context).emailSenhaErrado, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        break;
      default:
        Toast.show(S.of(context).erroLogin, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}
