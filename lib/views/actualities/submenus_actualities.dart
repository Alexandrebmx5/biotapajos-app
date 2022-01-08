import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/components/DrawerNavigation.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/styles/Color.dart';
import 'package:flutter/material.dart';

class SubMenusActualities extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: S.of(context).informe),
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
                  Navigator.of(context).pushNamed('/actualities');
                },
                title: Text(S.of(context).informeText),
                trailing: Icon(Icons.arrow_forward_ios, color: PRIMARY),
              ),
            ),
            Card(
              elevation: 4,
              color: Colors.white,
              child: ListTile(
                onTap: (){
                  Navigator.of(context).pushNamed('/actualities');
                },
                title: Text(S.of(context).actualities),
                trailing: Icon(Icons.arrow_forward_ios, color: PRIMARY),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
