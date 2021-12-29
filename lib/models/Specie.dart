import 'package:flutter/cupertino.dart';

class Specie {
  String _name;
  List _thumbnail = [];
  int _lenght;
  String _id;

  Specie(
      {@required String name,
      @required List thumbnail,
      @required id,
      int lenght}) {
    this._name = name;
    this._thumbnail = thumbnail;
    this._lenght = lenght;
    this._id = id;
  }

  List get thumbnail => _thumbnail;

  set thumbnail(List thumbnail) {
    _thumbnail = thumbnail;
  }

  int get lenght => _lenght;

  set lenght(int lenght) {
    _lenght = lenght;
  }

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  String get id => _id;

  set id(String id) {
    _id = id;
  }
}
