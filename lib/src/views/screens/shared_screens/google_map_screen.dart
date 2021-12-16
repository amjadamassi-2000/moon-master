import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// ignore: must_be_immutable
class GoogleMapScreen extends StatelessWidget {
  LocationData locationData;
  bool canEdit = false;
  @override
  Widget build(BuildContext context) {
    List data = ModalRoute.of(context).settings.arguments as List;
    locationData = data[0];
    canEdit = data[1];
    return GoogleMapScreenBody(locationData, canEdit);
  }
}

class GoogleMapScreenBody extends StatefulWidget {
  final LocationData locationData;
  final bool canEdit;

  GoogleMapScreenBody(this.locationData, this.canEdit);

  @override
  State<GoogleMapScreenBody> createState() => GoogleMapScreenBodyState();
}

class GoogleMapScreenBodyState extends State<GoogleMapScreenBody> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _userLocation;
  List<Marker> _markers;
  LatLng _selectedPosition;

//  static final CameraPosition _kLake = CameraPosition(
//      bearing: 192.8334901395799,
//      target: LatLng(37.43296265331129, -122.08832357078792),
//      tilt: 59.440717697143555,
//      zoom: 19.151926040649414);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userLocation = CameraPosition(
      target: LatLng(
        widget.locationData.latitude,
        widget.locationData.longitude,
      ),
      zoom: 14.4746,
    );
    _selectedPosition = _userLocation.target;
    _markers = [
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(
          widget.locationData.latitude,
          widget.locationData.longitude,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _userLocation,
        markers: Set.from(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        zoomControlsEnabled: false,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        onCameraMove: (position) {
          if (!widget.canEdit) return;
          setState(() {
            _markers = [
              Marker(
                markerId: MarkerId('1'),
                position: position.target,
              )
            ];
            _selectedPosition = position.target;
          });
        },
        onTap: (argument) {
          if (!widget.canEdit) return;
          setState(() {
            _markers = [
              Marker(
                markerId: MarkerId('1'),
                position: argument,
              )
            ];
          });
          _selectedPosition = argument;
        },
      ),
      floatingActionButton: !widget.canEdit
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                Navigator.pop(context, _selectedPosition);
              },
              child: Icon(
                Icons.check,
                color: Colors.green,
              ),
            ),
    );
//    floatingActionButton:
//    FloatingActionButton.extended(
//      onPressed: _goToTheLake,
//      label: Text('To the lake!'),
//      icon: Icon(Icons.directions_boat),
//    );
  }

//  Future<void> _goToTheLake() async {
//    final GoogleMapController controller = await _controller.future;
//    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//  }
}
