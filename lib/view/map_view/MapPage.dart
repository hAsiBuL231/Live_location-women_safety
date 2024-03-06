import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_track_live/.utils/Functions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  final String securityCode;
  const MapPage({super.key, required this.securityCode});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
  //static const LatLng _pApplePark = LatLng(23.45, 91.17);
  LatLng? _currentP;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getLocationUpdates().then((_) => {
          getPolylinePoints().then((coordinates) => {generatePolyLineFromPoints(coordinates), print(coordinates)})
        });
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 15);
    await controller.animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _currentP == null
            ? const Center(child: Text("Loading..."))
            : StreamBuilder(
                stream: FirebaseFirestore.instance.collection('User').doc(widget.securityCode).collection('location').doc('lat-long').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());

                  //showToast("${widget.securityCode}");

                  Set<Marker> markers = {};

                  final element = snapshot.data!.data();

                  if (element != null) {
                    //.doc(widget.securityCode).collection('location').doc('at-long')
                    _pGooglePlex = LatLng(element['latitude'], element['longitude']);
                    /*markers.add(Marker(
                        markerId: MarkerId('sdadd'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
                        position: LatLng(element['latitude'], element['longitude'])));*/

                    //markers.add(Marker(markerId: MarkerId("_currentLocation"), icon: , position: _currentP!));

                    markers.add(Marker(markerId: MarkerId("_currentLocation"), icon: BitmapDescriptor.defaultMarker, position: _currentP!));
                    markers
                        .add(Marker(markerId: MarkerId("userLocation"), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan), position: _pGooglePlex));
                    return GoogleMap(
                      onMapCreated: ((GoogleMapController controller) => _mapController.complete(controller)),
                      initialCameraPosition: CameraPosition(target: _pGooglePlex, zoom: 12),
                      /*markers: {
                      Marker(
                          markerId: MarkerId('id'),
                          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
                          position: LatLng(
                            snapshot.data!.docs.singleWhere((element) => element.id == widget.user_id)['latitude'],
                            snapshot.data!.docs.singleWhere((element) => element.id == widget.user_id)['longitude'],
                          )),
                      //Marker(markerId: MarkerId("_sourceLocation"), icon: BitmapDescriptor.defaultMarker, position: _pGooglePlex),
                      //Marker(markerId: MarkerId("_destionationLocation"), icon: BitmapDescriptor.defaultMarker, position: _pApplePark)
                    },*/
                      markers: markers,
                      polylines: Set<Polyline>.of(polylines.values),
                    );
                  } else
                    return Center(child: CircularProgressIndicator());
                },
              ));
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
        });
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyC_WdqkLQKoxjnUSUVgErrLoecARk430Z4",
      PointLatLng(_currentP!.latitude, _currentP!.longitude),
      PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
      travelMode: TravelMode.walking,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  // GOOGLE_MAPS_API_KEY = "AIzaSyC_WdqkLQKoxjnUSUVgErrLoecARk430Z4"

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(polylineId: id, color: Colors.black, points: polylineCoordinates, width: 8);
    setState(() {
      polylines[id] = polyline;
    });
  }
}
