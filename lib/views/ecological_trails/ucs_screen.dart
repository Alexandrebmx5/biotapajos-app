import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/models/ucs.dart';
import 'package:flutter/material.dart';

class UcsScreen extends StatelessWidget {

  UcsScreen(this.ucs);

  final Ucs ucs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: ucs.title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Text(ucs.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(
                    ucs.img[0],
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  ucs.paragraphOne,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14, letterSpacing: 1.0),
                ),
              ),
              if(ucs.img.length > 1)...[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    ucs.img[1],
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  ucs.paragraphTwo,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14, letterSpacing: 1.0),
                ),
              ),
              if(ucs.img.length > 2)...[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    ucs.img[2],
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  ucs.paragraphThree,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14, letterSpacing: 1.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  ucs.paragraphFour,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14, letterSpacing: 1.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
