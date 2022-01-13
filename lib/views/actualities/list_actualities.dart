import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/components/EasyLoading.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/models/actualities.dart';
import 'package:biotapajos_app/views/actualities/actualities_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';


class ListActualities extends StatefulWidget {

  @override
  _ListActualitiesState createState() => _ListActualitiesState();
}

class _ListActualitiesState extends State<ListActualities> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  String currentLang;
  Stream _stream = null;
  _initStream() {
    return db.collection('presently').snapshots();
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
        appBar: appBar(title: S.of(context).actualities),
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

              List<Actualities> actualities = [];

              documents.forEach((element) {
                if (currentLang == 'pt') {
                  Actualities presently = Actualities(
                      title: element['title'],
                      img: element['img'],
                      paragraphOne: element['paragraph_one'],
                      paragraphTwo: element['paragraph_two'],
                      paragraphThree: element['paragraph_three'],
                      paragraphFour: element['paragraph_four'],
                      id: element.id);
                  actualities.add(presently);
                } else {
                  Actualities presently = Actualities(
                      title: element['title_en'],
                      img: element['img'],
                      paragraphOne: element['paragraph_one_en'],
                      paragraphTwo: element['paragraph_two_en'],
                      paragraphThree: element['paragraph_three_en'],
                      paragraphFour: element['paragraph_four_en'],
                      id: element.id);
                  actualities.add(presently);
                }
              });

              if(actualities.isEmpty){
                dismiss();
                return Center(
                  child: Text('Nenhum dado registrado!'),
                );
              } else {
                return ListView.builder(
                  itemCount: actualities.length,
                  itemBuilder: (context, index) {
                    dismiss();
                    if (actualities.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ActualitiesScreen(
                                        actualities[index],
                                      )),
                                );
                              },
                              leading: Image.network(
                                actualities[index].img.first,
                                width: 50,
                                height: 50,
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(left: 64.0),
                                child: Text(actualities[index].title),
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
