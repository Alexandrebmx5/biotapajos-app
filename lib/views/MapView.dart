import 'dart:async';
import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/components/DrawerNavigation.dart';
import 'package:biotapajos_app/components/EasyLoading.dart';
import 'package:biotapajos_app/components/Inputs.dart';
import 'package:biotapajos_app/config/Auth.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/models/suggestions.dart';
import 'package:biotapajos_app/styles/Color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _search = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Suggestions> _tmpSpecies = [];
  Set<Marker> _markers = {};
  Set<Marker> _tmpMarker = {};

  static final CameraPosition _initialCamera = CameraPosition(
    target: LatLng(-9.668553771256917, -50.73260927807307),
    zoom: 3.0,
  );

  _checkUser() {
    if (!Auth.isLoged()) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _checkUser();
    _setMarkers();
    easyLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: S.of(context).mapa),
      drawer: drawer(context: context),
      body: body(),
      resizeToAvoidBottomInset: false,
    );
  }

  void _setMarkers() async {
    var doc = await db
        .collection('suggestions')
        .get();
    doc.docs.forEach((element) {
        Suggestions suggestions = Suggestions(
            id: element.id,
            nome: element.data()['name_user'],
            email: element.data()['email_user'],
            behavior: element.data()['behavior'],
            lat: element.data()['lat'],
            long: element.data()['long'],
            location: element.data()['location'],
            fileUrlString: element.data()['file_url'].toString(),
            approved: element.data()['approved'],
            nameSpecie: element.data()['name_specie'],
            date: element.data()['date'],
            time: element.data()['time'],
            sightedPlace: element.data()['sighted_place'],
            environment: element.data()['environment'],
            comment: element.data()['comment'],
            created: element.data()['created']);

        _tmpSpecies.add(suggestions);
      });

    _pointOnMap();

    dismiss();
  }

  void _pointOnMap() async {
    _tmpSpecies.forEach((element) {
      if (element.lat != null && element.long != null && element.approved == true) {
        LatLng latLng =
            LatLng(double.parse(element.lat), double.parse(element.long));
        Marker marker = Marker(
            markerId: MarkerId(element.id),
            position: latLng,
            onTap: () {

          showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  contentPadding: EdgeInsets.all(10),

                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(element.fileUrlString, width: 200, height: 200),
                      SizedBox(height: 10,),
                      Text(element.nameSpecie, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                      SizedBox(height: 20,),
                      Text(S.of(context).catalago),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
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
                );
              }
          );
        });
        _tmpMarker.add(marker);
      }
    });

    setState(() {
      _markers = _tmpMarker;
    });
  }

  void _filter() {
    _markers.clear();
    _tmpSpecies.forEach((element) {
      if (element.nameSpecie
          .toUpperCase()
          .contains(_search.text.toUpperCase().trim())) {
        _setPointing(element);
      }
    });
    setState(() {
      _markers = _tmpMarker;
    });
  }

  _setPointing(Suggestions element) {
    if (element.lat != null && element.long != null && element.approved == true) {
      LatLng latLng =
          LatLng(double.parse(element.lat), double.parse(element.long));
      Marker marker = Marker(
          markerId: MarkerId(element.id),
          position: latLng,
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    contentPadding: EdgeInsets.all(10),

                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(element.fileUrlString, width: 200, height: 200),
                        SizedBox(height: 10,),
                        Text(element.nameSpecie, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                        SizedBox(height: 20,),
                        Text(S.of(context).catalago),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
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
                  );
                }
            );
          });
      _tmpMarker.add(marker);
    }

    setState(() {
      _markers = _tmpMarker;
    });
  }

  Widget body() {
    return Stack(
      children: [
        GoogleMap(
          markers: _markers,
          mapType: MapType.normal,
          initialCameraPosition: _initialCamera,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        _searchBar(),
      ],
    );
  }

  Widget _searchBar() {
    if (_tmpSpecies != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 5),
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          elevation: 4,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: Row(
                children: [
                  Expanded(
                      child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    child: inputTextPass(
                        controller: _search,
                        hint: S.of(context).pesquisarPorNome,
                        obscure: false,
                        context: context),
                  )),
                  IconButton(
                      onPressed: () {
                        _filter();
                      },
                      icon: Icon(
                        Icons.search,
                        color: PRIMARY,
                      ))
                ],
              )),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
