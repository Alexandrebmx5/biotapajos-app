import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/components/Empty.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class Actualities extends StatefulWidget {
  @override
  _ActualitiesState createState() => _ActualitiesState();
}

class _ActualitiesState extends State<Actualities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: S.of(context).informe),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          notFinished(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.height * 0.35),
          Text(
            S.of(context).emConstrucao,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          )
        ],
      ),
    );
  }
}
