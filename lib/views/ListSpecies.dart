import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/components/Buttons.dart';
import 'package:biotapajos_app/components/DrawerNavigation.dart';
import 'package:biotapajos_app/components/EasyLoading.dart';
import 'package:biotapajos_app/components/Inputs.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/models/Specie.dart';
import 'package:biotapajos_app/models/SpecieDetail.dart';
import 'package:biotapajos_app/styles/Color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ListSpecies extends StatefulWidget {
  @override
  _ListSpeciesState createState() => _ListSpeciesState();
  Specie specie;
  ListSpecies({Specie specie}) {
    this.specie = specie;
  }
}

class _ListSpeciesState extends State<ListSpecies> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  List<SpecieDetail> speciesDetails = [];
  TextEditingController _search = TextEditingController();
  Stream _stream = null;
  String _currentLang;
  String _field = 'name';

  Stream _getSpecies({String id}) {
    Stream result = _db
        .collection('species')
        .doc(widget.specie.id)
        .collection('subspecies')
        .orderBy('specie')
        .snapshots();
    return result;
  }

  List _filter({List rawList, String query, String field}) {
    if (query.isEmpty) {
      return rawList;
    } else {
      switch (field) {
        case 'specie':
          rawList.removeWhere((element) => element.name != null
              ? !(element.name.toUpperCase().contains(query.toUpperCase()))
              : null);
          break;

        case 'color':
          rawList.removeWhere((element) => element.color != null
              ? !(element.color.toUpperCase().contains(query.toUpperCase()))
              : null);
          break;
        default:
          return rawList;
      }

      List tmp = rawList;

      return tmp;
    }
  }

  void _nextScreen({SpecieDetail specie}) {
    Navigator.pushNamed(context, '/species/list/information',
        arguments: specie);
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
    easyLoading();
    _stream = _getSpecies(id: widget.specie.id);
    _setLanguage();
    _currentLang = Intl.getCurrentLocale();
    dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(title: widget.specie.name),
      drawer: drawer(context: context),
      body: body(id: widget.specie.id),
    );
  }

  Widget body({@required String id}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 8.0),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: btFilter(
                              context: context,
                              call: (value) {
                                setState(() {
                                  _field = value;
                                });
                              }),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            width: constraints.maxWidth,
                            height: constraints.maxHeight * 0.08,
                            child: inputText(
                                controller: _search,
                                hint: S.of(context).pesquisarPorNome,
                                obscure: false,
                                context: context),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {});
                            },
                            icon: Icon(Icons.search))
                      ],
                    )),
              ),
            ),
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.90,
              child: StreamBuilder(
                stream: _stream,
                builder: (context, snapshot) {
                  if (ConnectionState.waiting == snapshot.connectionState) {
                    return SizedBox();
                  } else {
                    List<QueryDocumentSnapshot> docs = [];
                    docs.clear();
                    speciesDetails.clear();
                    docs = snapshot.data.docs;
                    docs.forEach((element) {
                      if (_currentLang == 'pt') {
                        SpecieDetail specieDetail = SpecieDetail(
                            id: element.id,
                            name: element.data()['nome'],
                            specie: element.data()['specie'],
                            active: element.data()['active'],
                            howKnow: element.data()['howKnow'],
                            lat: element.data()['lat'],
                            locations: element.data()['locations'],
                            long: element.data()['long'],
                            reproduction: element.data()['reproduction'],
                            family: element.data()['family'],
                            youKnow: element.data()['youKnow'],
                            img: element.data()['img'],
                            color: element.data()['color'],
                            sound: element.data()['sound']);

                        speciesDetails.add(specieDetail);
                      } else {
                        SpecieDetail specieDetail = SpecieDetail(
                            id: element.id,
                            name: element.data()['nome_en'],
                            specie: element.data()['specie_en'],
                            active: element.data()['active_en'],
                            howKnow: element.data()['howKnow_en'],
                            lat: element.data()['lat'],
                            locations: element.data()['locations_en'],
                            long: element.data()['long'],
                            reproduction: element.data()['reproduction_en'],
                            family: element.data()['family_en'],
                            youKnow: element.data()['youKnow_en'],
                            img: element.data()['img'],
                            color: element.data()['color_en'],
                            sound: element.data()['sound']);

                        speciesDetails.add(specieDetail);
                      }
                    });

                    if (speciesDetails.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Center(
                          child: Text('nenhuma espécie encontrada!', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),),
                        ),
                      );
                    } else {
                      String sub = speciesDetails[0].specie;
                      return ListView.builder(
                        itemCount: _filter(
                            rawList: speciesDetails,
                            query: _search.text,
                            field: _field)
                            .length,
                        itemBuilder: (context, index) {
                          dismiss();
                          if (_filter(
                              rawList: speciesDetails, query: _search.text)
                              .isNotEmpty) {
                            if (index == 0) {
                              return Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Container(
                                        width: constraints.maxWidth,
                                        height: 30,
                                        color: PRIMARY,
                                        child: Center(
                                          child: Text(
                                            sub,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        onTap: () {
                                          _nextScreen(
                                              specie: speciesDetails[index]);
                                        },
                                        leading: Image.network(
                                          speciesDetails[index].img[0],
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.fill,
                                        ),
                                        title: Text(
                                          speciesDetails[index].name,
                                        ),
                                        subtitle: Padding(
                                          padding:
                                          const EdgeInsets.only(top: 8.0),
                                          child: Text(speciesDetails[index]
                                              .family),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                      Divider(height: 2, color: Colors.grey),
                                    )
                                  ],
                                ),
                              );
                            } else if (sub != speciesDetails[index].specie) {
                              sub = speciesDetails[index].specie;
                              return Container(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0),
                                        child: Container(
                                          width: constraints.maxWidth,
                                          height: 30,
                                          color: PRIMARY,
                                          child: Center(
                                            child: Text(
                                              sub,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          onTap: () {
                                            _nextScreen(
                                                specie: speciesDetails[index]);
                                          },
                                          leading: Image.network(
                                            speciesDetails[index].img[0],
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.fill,
                                          ),
                                          title: Text(
                                              speciesDetails[index].specie),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0),
                                            child: Text(
                                                speciesDetails[index]
                                                    .family),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Divider(
                                            height: 2, color: Colors.grey),
                                      )
                                    ],
                                  ));
                            }
                            return Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        onTap: () {
                                          _nextScreen(
                                              specie: speciesDetails[index]);
                                        },
                                        leading: Image.network(
                                          speciesDetails[index].img[0],
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.fill,
                                        ),
                                        title: Text(speciesDetails[index].specie),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0),
                                          child: Text(
                                              speciesDetails[index]
                                                  .family),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Divider(
                                          height: 2, color: Colors.grey),
                                    )
                                  ],
                                ));
                          } else {
                            return SizedBox();
                          }
                        },
                      );
                    }
                  }
                },
              ),
            )
          ],
        );
      },
    );
  }
}
