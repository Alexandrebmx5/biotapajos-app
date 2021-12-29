import 'package:biotapajos_app/styles/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

Widget inputText(
    {@required TextEditingController controller,
    @required String hint,
    @required bool obscure,
    @required context}) {
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(100)),
    child: Center(
      child: TextField(
        obscureText: obscure,
        controller: controller,
        cursorColor: PRIMARY,
        style: TextStyle(
          color: PRIMARY,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            color: PRIMARY,
            fontSize: 14,
          ),
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
      ),
    ),
  );
}

Widget inputTextPass(
    {@required TextEditingController controller,
    @required String hint,
    @required bool obscure,
    @required context}) {
  return TextField(
    obscureText: obscure,
    controller: controller,
    cursorColor: PRIMARY,
    style: TextStyle(color: PRIMARY, fontSize: 14),
    decoration: InputDecoration(
      fillColor: Colors.white,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      hintText: hint,
      hintStyle: TextStyle(color: PRIMARY, fontSize: 14),
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    ),
  );
}

Widget inputNumberMask(
    {@required TextEditingController controller,
    @required String hint,
    @required bool obscure,
    @required context}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(100))),
    child: TextField(
      obscureText: obscure,
      controller: controller,
      cursorColor: PRIMARY,
      style: TextStyle(color: PRIMARY, fontSize: 14),
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(color: PRIMARY, fontSize: 14),
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      keyboardType: TextInputType.phone,
      inputFormatters: [
        PhoneInputFormatter(
          onCountrySelected: (value) {
            print(value);
          },
          allowEndlessPhone: false,
        )
      ],
    ),
  );
}
