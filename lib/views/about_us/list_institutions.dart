import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/components/EasyLoading.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ListInstitutions extends StatefulWidget {
  @override
  _ListInstitutionsState createState() => _ListInstitutionsState();
}

class _ListInstitutionsState extends State<ListInstitutions> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Future _about;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _about = _db
        .collection('partner_institutions')
        .doc('gB4TTNA4N1JUkfuAJPf8')
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: S.of(context).parceria),
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
              List _img = [];
              _img = _doc.data()['logo'];
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 30),
                  itemCount: _img.length,
                  itemBuilder: (context, index) {
                    dismiss();

                    return Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Image.network(_img[index],
                          height: 150),
                    );
                  });
            } else {
              return SizedBox();
            }
          }
        },
      ),
    );
  }
}
