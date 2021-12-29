import 'package:biotapajos_app/styles/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget appBar({@required title}) {
  return AppBar(
    title: Text(title, style: TextStyle(fontSize: 16),),
    backgroundColor: PRIMARY,
    centerTitle: true,
  );
}
