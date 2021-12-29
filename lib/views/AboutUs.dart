import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/components/DrawerNavigation.dart';
import 'package:biotapajos_app/components/EasyLoading.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Future _about;
  String _currentLang = Intl.getCurrentLocale();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _about = _db.collection('aboutUs').doc('about_us').get();
    _currentLang = Intl.getCurrentLocale();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: S.of(context).quemSomos),
      drawer: drawer(context: context),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
        future: _about,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            easyLoading();
            return SizedBox();
          } else {
            EasyLoading.dismiss();
            DocumentSnapshot _doc = snapshot.data;
            if (snapshot.hasData) {
              String _text = '';
              if (_currentLang == 'pt') {
                _text = _doc.data()['pt'];
              } else {
                _text = _doc.data()['en'];
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('images/logo_inst.png',
                        height: MediaQuery.of(context).size.height * 0.30,
                        width: MediaQuery.of(context).size.height * 0.30),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 64.0, left: 16, right: 16, bottom: 16),
                      child: Text(
                        _text,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 14, letterSpacing: 1.2),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          }
        },
      ),
    );
  }
}
