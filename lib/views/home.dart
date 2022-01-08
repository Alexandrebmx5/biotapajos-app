import 'package:biotapajos_app/components/DrawerNavigation.dart';
import 'package:biotapajos_app/components/Empty.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/styles/Color.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/fundo.png'),
          fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.85),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: bgCOLOR),
        ),
        drawer: drawer(context: context),
        body: body(),
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 16, right: 16, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('images/logo_no_bg.png', height: 120,),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                S.of(context).BemVindoaoBioTapajos,
                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                S.of(context).Guia,
                style: TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    S.of(context).homeText1,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    S.of(context).homeText2,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textAlign: TextAlign.justify,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50, top: 5),
                    child: ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed('/species');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: PRIMARY,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                        ),
                        child: Text(S.of(context).homeButton)
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    S.of(context).homeText3,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50, top: 5),
                    child: ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed('/about');
                        },
                        style: ElevatedButton.styleFrom(
                            primary: PRIMARY,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                        ),
                        child: Text(S.of(context).homeButton)
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bodyConstruction() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          notFinished(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.height * 0.35),
          Text(
            S.of(context).emConstrucao,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          )
        ],
      ),
    );
  }
}
