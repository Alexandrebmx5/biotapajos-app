import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/components/EasyLoading.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/models/trails.dart';
import 'package:biotapajos_app/views/ecological_trails/trails_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';


class ListTrails extends StatefulWidget {

  @override
  _ListTrailsState createState() => _ListTrailsState();
}

class _ListTrailsState extends State<ListTrails> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  String currentLang;
  Stream _stream = null;
  _initStream() {
    return db.collection('trails').snapshots();
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
        appBar: appBar(title: S.of(context).trilhasEcologicas),
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

              List<Trails> trails = [];

              documents.forEach((element) {
                if (currentLang == 'pt') {
                  Trails trail = Trails(
                      title: element['title'],
                      img: element['img'],
                      paragraphOne: element['paragraph_one'],
                      paragraphTwo: element['paragraph_two'],
                      paragraphThree: element['paragraph_three'],
                      paragraphFour: element['paragraph_four'],
                      id: element.id);
                  trails.add(trail);
                } else {
                  Trails trail = Trails(
                      title: element['title_en'],
                      img: element['img'],
                      paragraphOne: element['paragraph_one_en'],
                      paragraphTwo: element['paragraph_two_en'],
                      paragraphThree: element['paragraph_three_en'],
                      paragraphFour: element['paragraph_four_en'],
                      id: element.id);
                  trails.add(trail);
                }
              });

              if(trails.isEmpty){
                dismiss();
                return Center(
                  child: Text('Nenhum dado registrado!'),
                );
              } else {
                return ListView.builder(
                  itemCount: trails.length,
                  itemBuilder: (context, index) {
                    dismiss();
                    if (trails.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TrailsScreen(
                                        trails[index],
                                      )),
                                );
                              },
                              leading: Image.network(
                                trails[index].img.first,
                                width: 50,
                                height: 50,
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(left: 64.0),
                                child: Text(trails[index].title),
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
