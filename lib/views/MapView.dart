import 'dart:async';
import 'package:biotapajos_app/components/DrawerNavigation.dart';
import 'package:biotapajos_app/components/EasyLoading.dart';
import 'package:biotapajos_app/components/Inputs.dart';
import 'package:biotapajos_app/components/MapComponent.dart';
import 'package:biotapajos_app/config/Auth.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/models/SpecieDetail.dart';
import 'package:biotapajos_app/styles/Color.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
  SpecieDetail specieDetail;
  MapView({SpecieDetail specieDetail}) {
    this.specieDetail = specieDetail;
  }
}

class _MapViewState extends State<MapView> {
  _setLanguage() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String lang = _sharedPreferences.get('lang');
    setState(() {
      S.load(Locale.fromSubtags(languageCode: lang));
    });
  }

  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _search = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<SpecieDetail> _tmpSpecies = [];
  List<SpecieDetail> _species = [];
  String _currentLang;
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

  _getSpecies() async {
    if (widget.specieDetail == null) {
      QuerySnapshot _result = await db.collection('species').get();
      List<DocumentSnapshot> docs = _result.docs;
      docs.forEach((element) {
        _setMarkers(element);
      });

      setState(() {
        _markers = _tmpMarker;
      });
    } else {
      if (widget.specieDetail.lat != null && widget.specieDetail.long != null) {
        LatLng latLng = LatLng(double.parse(widget.specieDetail.lat),
            double.parse(widget.specieDetail.long));
        Marker marker = Marker(
            markerId: MarkerId(widget.specieDetail.id),
            position: latLng,
            infoWindow: InfoWindow(title: widget.specieDetail.name));
        _tmpMarker.clear();
        _markers.clear();
        _tmpMarker.add(marker);
      }

      setState(() {
        _markers = _tmpMarker;
      });
    }
    Future.delayed(Duration(seconds: 2), () {
      EasyLoading.dismiss();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _checkUser();
    _setLanguage();
    _currentLang = Intl.getCurrentLocale();
    _getSpecies();
    easyLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: _searchBar(),
        ),
        backgroundColor: PRIMARY,
      ),
      drawer: drawer(context: context),
      body: body(),
      resizeToAvoidBottomInset: false,
    );
  }

  void _setMarkers(DocumentSnapshot documentSnapshot) async {
    var doc = await db
        .collection('species')
        .doc(documentSnapshot.id)
        .collection('subspecies')
        .get();
    doc.docs.forEach((element) {
      //logica para adicionar oa obj

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

        _tmpSpecies.add(specieDetail);
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

        _tmpSpecies.add(specieDetail);
      }
    });
    setState(() {
      _species = _tmpSpecies;
    });

    _pointOnMap();
  }

  void _pointOnMap() async {
    _species.forEach((element) {
      if (element.lat != null && element.long != null) {
        LatLng latLng =
            LatLng(double.parse(element.lat), double.parse(element.long));
        Marker marker = Marker(
            markerId: MarkerId(element.id),
            position: latLng,
            infoWindow: InfoWindow(title: element.name));
        _tmpMarker.add(marker);
      }
    });

    setState(() {
      _tmpMarker;
    });
  }

  void _filter() {
    _markers.clear();
    _species.forEach((element) {
      if (element.name
          .toUpperCase()
          .contains(_search.text.toUpperCase().trim())) {
        _setPointing(element);
      }
    });
    setState(() {
      _markers = _tmpMarker;
    });
  }

  _setPointing(SpecieDetail element) {
    if (element.lat != null && element.long != null) {
      LatLng latLng =
          LatLng(double.parse(element.lat), double.parse(element.long));
      Marker marker = Marker(
          markerId: MarkerId(element.id),
          position: latLng,
          infoWindow: InfoWindow(title: element.name));
      _tmpMarker.add(marker);
    }

    setState(() {
      _tmpMarker;
    });
  }

  Widget body() {
    return Stack(
      children: [
        MapComponent(
          controller: _controller,
          initialCamera: _initialCamera,
          markers: _markers,
        ),
      ],
    );
  }

  Widget _searchBar() {
    if (widget.specieDetail == null) {
      return Padding(
        padding: const EdgeInsets.only(left: 47.0, right: 10.0, top: 20.0, bottom: 5),
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
