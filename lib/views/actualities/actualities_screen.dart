import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/models/actualities.dart';
import 'package:flutter/material.dart';

class ActualitiesScreen extends StatelessWidget {

  ActualitiesScreen(this.actualities);

  final Actualities actualities;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: actualities.title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Text(actualities.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  actualities.img[0],
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  actualities.paragraphOne,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14, letterSpacing: 1.0),
                ),
              ),
              if(actualities.img.length > 1)...[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    actualities.img[1],
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  actualities.paragraphTwo,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14, letterSpacing: 1.0),
                ),
              ),
              if(actualities.img.length > 2)...[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    actualities.img[2],
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  actualities.paragraphThree,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14, letterSpacing: 1.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  actualities.paragraphFour,
                  textAlign: TextAlign.start,
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
