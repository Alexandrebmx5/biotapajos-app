import 'package:flutter/material.dart';

Widget textIcon({child, String text, TextStyle style}) {
  return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(children: [
        WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: child,
            )),
        WidgetSpan(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: style,
          ),
        ))
      ]));
}
