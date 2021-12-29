import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/components/DrawerNavigation.dart';
import 'package:biotapajos_app/components/EasyLoading.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/models/Specie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'ListSpecies.dart';

class Species extends StatefulWidget {
  @override
  _SpeciesState createState() => _SpeciesState();
}

class _SpeciesState extends State<Species> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String currentLang;
  Stream _stream = null;
  _initStream() {
    return db.collection('species').snapshots();
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
      appBar: appBar(title: S.of(context).catalago),
      drawer: drawer(context: context),
      body: body(),
    );
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

              List<Specie> species = [];

              documents.forEach((element) {
                if (currentLang == 'pt') {
                  Specie specie = Specie(
                      name: element['pt'],
                      thumbnail: element['img'],
                      id: element.id);
                  species.add(specie);
                } else {
                  Specie specie = Specie(
                      name: element['en'],
                      thumbnail: element['img'],
                      id: element.id);
                  species.add(specie);
                }
              });

              return ListView.builder(
                itemCount: species.length,
                itemBuilder: (context, index) {
                  dismiss();
                  if (species.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListSpecies(
                                          specie: species[index],
                                        )),
                              );
                            },
                            leading: Image.network(
                              species[index].thumbnail.first,
                              width: 50,
                              height: 50,
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(left: 64.0),
                              child: Text(species[index].name),
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
          },
        ));
  }
}
