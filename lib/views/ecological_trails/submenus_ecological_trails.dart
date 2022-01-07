import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/components/DrawerNavigation.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/styles/Color.dart';
import 'package:biotapajos_app/views/ecological_trails/EcologicalTrails.dart';
import 'package:biotapajos_app/views/ecological_trails/list_ucs.dart';
import 'package:flutter/material.dart';

class SubMenusEcologicalTrails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: S.of(context).trilhas),
      drawer: drawer(context: context),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              elevation: 4,
              color: Colors.white,
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ListUcs()));
                },
                title: Text(S.of(context).ucs),
                trailing: Icon(Icons.arrow_forward_ios, color: PRIMARY),
              ),
            ),
            Card(
              elevation: 4,
              color: Colors.white,
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>EcologicalTrails()));
                },
                title: Text(S.of(context).trilhasEcologicas),
                trailing: Icon(Icons.arrow_forward_ios, color: PRIMARY),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
