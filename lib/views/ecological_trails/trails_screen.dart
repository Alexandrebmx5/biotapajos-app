import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/models/trails.dart';
import 'package:flutter/material.dart';

class TrailsScreen extends StatelessWidget {

  TrailsScreen(this.trails);

  final Trails trails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: trails.title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Text(trails.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  trails.img[0],
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  trails.paragraphOne,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14, letterSpacing: 1.0),
                ),
              ),
              if(trails.img.length > 1)...[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    trails.img[1],
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  trails.paragraphTwo,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14, letterSpacing: 1.0),
                ),
              ),
              if(trails.img.length > 2)...[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    trails.img[2],
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  trails.paragraphThree,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14, letterSpacing: 1.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  trails.paragraphFour,
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
