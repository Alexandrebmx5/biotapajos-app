import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/components/DrawerNavigation.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/styles/Color.dart';
import 'package:biotapajos_app/views/about_us/AboutUs.dart';
import 'package:biotapajos_app/views/about_us/list_collaborators.dart';
import 'package:biotapajos_app/views/about_us/list_institutions.dart';
import 'package:biotapajos_app/views/about_us/list_team.dart';
import 'package:biotapajos_app/views/about_us/our_story.dart';
import 'package:flutter/material.dart';

class SubMenusAboutUs extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: S.of(context).quemSomos),
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>OurStory()));
                },
                // TODO: EN E PT
                title: Text('Nossa História', style: TextStyle(color: Colors.black)),
                trailing: Icon(Icons.arrow_forward_ios, color: PRIMARY),
              ),
            ),
            Card(
              elevation: 4,
              color: Colors.white,
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AboutUs()));
                },
                // TODO: EN E PT
                title: Text('Conheça o IAA', style: TextStyle(color: Colors.black)),
                trailing: Icon(Icons.arrow_forward_ios, color: PRIMARY),
              ),
            ),
            Card(
              elevation: 4,
              color: Colors.white,
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ListTeam()));
                },
                // TODO: EN E PT
                title: Text('Conheça nossa equipe', style: TextStyle(color: Colors.black)),
                trailing: Icon(Icons.arrow_forward_ios, color: PRIMARY),
              ),
            ),
            Card(
              elevation: 4,
              color: Colors.white,
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ListCollaborators()));
                },
                // TODO: EN E PT
                title: Text('Colaboradores', style: TextStyle(color: Colors.black)),
                trailing: Icon(Icons.arrow_forward_ios, color: PRIMARY),
              ),
            ),
            Card(
              elevation: 4,
              color: Colors.white,
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ListInstitutions()));
                },
                // TODO: EN E PT
                title: Text('Instituições parceiras', style: TextStyle(color: Colors.black)),
                trailing: Icon(Icons.arrow_forward_ios, color: PRIMARY),
              ),
            )
          ],
        ),
      ),
    );
  }
}