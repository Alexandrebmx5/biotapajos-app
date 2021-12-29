import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/components/DrawerNavigation.dart';
import 'package:biotapajos_app/components/EasyLoading.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/helper/LaunchUrl.dart';
import 'package:biotapajos_app/models/PdfFiles.dart';
import 'package:biotapajos_app/styles/Color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EcologicalTrails extends StatefulWidget {
  @override
  _EcologicalTrailsState createState() => _EcologicalTrailsState();
}

class _EcologicalTrailsState extends State<EcologicalTrails> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  List<PdfFiles> _pdfs = [];
  Stream _stream;
  Stream _initStream() {
    return _db.collection('pdf').snapshots();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stream = _initStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: S.of(context).trilhas),
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              easyLoading();
              return SizedBox();
            } else {
              EasyLoading.dismiss();
              _pdfs.clear();
              if (snapshot.hasData) {
                snapshot.data.docs.forEach((element) {
                  PdfFiles pdfFiles =
                      PdfFiles(file_url: element.data()['file_url']);
                  _pdfs.add(pdfFiles);
                });

                return _listView(pdfs: _pdfs);
              } else {
                return SizedBox();
              }
            }
          },
        ));
  }

  _listView({List<PdfFiles> pdfs}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: ListView.builder(
          itemCount: pdfs.length,
          itemBuilder: (context, index) {
            String fullPath =
                _storage.refFromURL(pdfs[index].file_url).fullPath;
            String name = fullPath.split('/').last;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(
                  Icons.file_present,
                  color: PRIMARY,
                ),
                title: Text(name),
                onTap: () {
                  launchURL(url: pdfs[index].file_url);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

//launchURL(context: context, url: _url);
