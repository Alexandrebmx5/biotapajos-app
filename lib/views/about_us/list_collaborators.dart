import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/components/EasyLoading.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/models/collaborators.dart';
import 'package:biotapajos_app/models/team.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ListCollaborators extends StatefulWidget {
  @override
  _ListCollaboratorsState createState() => _ListCollaboratorsState();
}

class _ListCollaboratorsState extends State<ListCollaborators> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String currentLang;
  Stream _stream = null;
  _initStream() {
    return db.collection('collaborators').snapshots();
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
    return Scaffold(appBar: appBar(title: S.of(context).colaboradoes), body: body());
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

              List<Collaborators> collaborators = [];

              documents.forEach((element) {
                if (currentLang == 'pt') {
                  Collaborators collaborator = Collaborators(
                      img: element['img'],
                      name: element['name'],
                      description: element['description_pt'],
                      id: element.id);
                  collaborators.add(collaborator);
                } else {
                  Collaborators collaborator = Collaborators(
                      img: element['img'],
                      name: element['name'],
                      description: element['description_en'],
                      id: element.id);
                  collaborators.add(collaborator);
                }
              });

              return ListView.builder(
                itemCount: collaborators.length,
                itemBuilder: (context, index) {
                  dismiss();
                  if (collaborators.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          if(collaborators[index].img.isNotEmpty)
                            Image.network(
                              collaborators[index].img.first,
                              height: 100,
                            ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(collaborators[index].name, style: TextStyle(fontWeight: FontWeight.bold)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(collaborators[index].description,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
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
