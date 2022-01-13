import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/components/EasyLoading.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/models/report.dart';
import 'package:biotapajos_app/views/actualities/report_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';


class ListReport extends StatefulWidget {

  @override
  _ListReportState createState() => _ListReportState();
}

class _ListReportState extends State<ListReport> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  String currentLang;
  Stream _stream = null;
  _initStream() {
    return db.collection('infos').snapshots();
  }

  _setLanguage() async {
    SharedPreferences _sharedPreferences =
    await SharedPreferences.getInstance();
    String lang = _sharedPreferences.get('lang');
    setState(() {
      S.load(Locale.fromSubtags(languageCode: lang));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stream = _initStream();
    easyLoading();
    _setLanguage();

    currentLang = Intl.getCurrentLocale();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(title: S.of(context).informeText),
        body: body());
  }

  Widget body() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (ConnectionState.waiting == snapshot.connectionState) {
              return SizedBox();
            } else {
              //Create ListView
              List<QueryDocumentSnapshot> documents =
              snapshot.data.docs.toList();

              List<Report> reports = [];

              documents.forEach((element) {
                if (currentLang == 'pt') {
                  Report report = Report(
                      title: element['title'],
                      img: element['img'],
                      paragraphOne: element['paragraph_one'],
                      paragraphTwo: element['paragraph_two'],
                      paragraphThree: element['paragraph_three'],
                      paragraphFour: element['paragraph_four'],
                      id: element.id);
                  reports.add(report);
                } else {
                  Report report = Report(
                      title: element['title_en'],
                      img: element['img'],
                      paragraphOne: element['paragraph_one_en'],
                      paragraphTwo: element['paragraph_two_en'],
                      paragraphThree: element['paragraph_three_en'],
                      paragraphFour: element['paragraph_four_en'],
                      id: element.id);
                  reports.add(report);
                }
              });

              if(reports.isEmpty){
                dismiss();
                return Center(
                  child: Text('Nenhum dado registrado!'),
                );
              } else {
                return ListView.builder(
                  itemCount: reports.length,
                  itemBuilder: (context, index) {
                    dismiss();
                    if (reports.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReportScreen(
                                        reports[index],
                                      )),
                                );
                              },
                              leading: Image.network(
                                reports[index].img.first,
                                width: 50,
                                height: 50,
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(left: 64.0),
                                child: Text(reports[index].title),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Divider(
                                color: Colors.grey,
                                height: 2,
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                );
              }

            }
          },
        ));
  }
}
