import 'dart:async';
import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/styles/Color.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toast/toast.dart';

class GetCoordinate extends StatefulWidget {
  @override
  _GetCoordinateState createState() => _GetCoordinateState();
}

class _GetCoordinateState extends State<GetCoordinate> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initialCamera = CameraPosition(
    target: LatLng(-9.668553771256917, -50.73260927807307),
    zoom: 3.0,
  );
  Set<Marker> _marker = Set();
  LatLng _selectedPoint;
  Set<Marker> _setMarker(LatLng point) {
    Set<Marker> mark = Set();
    Marker marker = Marker(
      markerId: MarkerId('initialMarker'),
      position: point,
      infoWindow: InfoWindow(
          title: S.of(context).coordenadas,
          snippet: 'Lat: ${point.latitude}  Long: ${point.longitude}'),
    );
    mark.add(marker);
    return mark;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: S.of(context).coordenadas),
      resizeToAvoidBottomInset: false,
      body: body(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 40),
        child: FloatingActionButton(
          backgroundColor: PRIMARY,
          child: Icon(Icons.check),
          onPressed: () {
            if (_selectedPoint != null) {
              Navigator.pushReplacementNamed(context, '/suges',
                  arguments: _selectedPoint);
            } else {
              Toast.show(S.of(context).erroCoordenada, context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            }
          },
        ),
      ),
    );
  }

  Widget body() {
    return Container(
        child: GoogleMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      mapType: MapType.normal,
      markers: _marker,
      initialCameraPosition: _initialCamera,
      onTap: (LatLng point) {
        setState(() {
          _marker = _setMarker(point);
          _selectedPoint = point;
        });
      },
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    ));
  }
}
