import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/models/report.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {

  ReportScreen(this.report);

  final Report report;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: report.title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Text(report.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  report.img[0],
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  report.paragraphOne,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14, letterSpacing: 1.0),
                ),
              ),
              if(report.img.length > 1)...[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    report.img[1],
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  report.paragraphTwo,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14, letterSpacing: 1.0),
                ),
              ),
              if(report.img.length > 2)...[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    report.img[2],
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  report.paragraphThree,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14, letterSpacing: 1.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  report.paragraphFour,
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
