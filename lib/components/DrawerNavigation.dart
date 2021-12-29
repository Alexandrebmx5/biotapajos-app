import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/styles/Color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Drawer drawer({@required context}) {
  FirebaseAuth _auth = FirebaseAuth.instance;

  return Drawer(
      child: Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _auth.currentUser.photoURL != null
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(_auth.currentUser.photoURL),
                            minRadius: 30,
                            maxRadius: 40,
                          )
                        : CircleAvatar(
                            minRadius: 30,
                            maxRadius: 40,
                            foregroundImage: AssetImage('images/BioCheck_Avatar1.jpg'),
                            ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: Text(_auth.currentUser.displayName),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text(_auth.currentUser.email),
                    )
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: Divider(
              color: PRIMARY,
              height: 1,
            ),
          ),
          Expanded(
            child: Center(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.home,
                      color: PRIMARY,
                    ),
                    title: Text(
                      'Home',
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.view_list,
                      color: PRIMARY,
                    ),
                    title: Text(
                      S.of(context).trilhas,
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/trails');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.playlist_play_rounded,
                      color: PRIMARY,
                    ),
                    title: Text(
                      S.of(context).informe,
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/actualities');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.search,
                      color: PRIMARY,
                    ),
                    title: Text(
                      S.of(context).catalago,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/species');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.location_on,
                      color: PRIMARY,
                    ),
                    title: Text(
                      S.of(context).mapa,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/map');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.description_outlined,
                      color: PRIMARY,
                    ),
                    title: Text(
                      S.of(context).registro,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/suges');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.search,
                      color: PRIMARY,
                    ),
                    title: Text(
                      S.of(context).quemSomos,
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/about');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: PRIMARY,
                    ),
                    title: Text(
                      S.of(context).sair,
                    ),
                    onTap: () {
                      FirebaseAuth _auth = FirebaseAuth.instance;
                      _auth.signOut();
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 20, bottom: 20, top: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'v. 1.0.1+1',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  ));
}
