import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapComponent extends StatelessWidget {
   var _initialCamera;
   Completer<GoogleMapController> _controller;
   var _markers;
    MapComponent({initialCamera,controller,markers}){
        this._initialCamera = initialCamera;
        this._controller = controller;
        this._markers = markers;

    }
  @override
  Widget build(BuildContext context) {
        print(_controller.isCompleted);
    return GoogleMap(

      mapType: MapType.normal,
      initialCameraPosition: _initialCamera,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);

      },
      markers: _markers,
    );
  }
}
