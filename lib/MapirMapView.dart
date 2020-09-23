import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:map_controller/map_controller.dart';

import 'MapirMap.dart';

class MapirMapView extends StatefulWidget {
  StatefulMapController statefulMapController;
  MapController mapController;
  VoidCallback onMapReady;
  Function(LatLng) onMapClick;
  Function(LatLng) onMapLongClick;
  Function(LatLng) onLocationUpdate;
  LatLng lastKnownLocation;
  bool showLocationMarker;

  MapirMapView(
      {Key key,
      this.mapController,
      this.statefulMapController,
      this.onMapReady,
      this.onMapClick,
      this.onMapLongClick,
      this.onLocationUpdate,
      this.showLocationMarker = false})
      : super(key: key);

  @override
  _MapirMapViewState createState() => _MapirMapViewState();
}

class _MapirMapViewState extends State<MapirMapView> {
  StreamSubscription<StatefulMapControllerStateChange> sub;

  MapOptions mapOptions;

  @override
  void initState() {
    // wait for the controller to be ready before using it
    widget.statefulMapController.onReady.then((_) => widget.onMapReady());

    /// [Important] listen to the changefeed to rebuild the map on changes:
    /// this will rebuild the map when for example addMarker or any method
    /// that mutates the map assets is called
    sub = widget.statefulMapController.changeFeed
        .listen((change) => setState(() {}));

    mapOptions = MapOptions(
        center: LatLng(35.713949, 51.399086),
        zoom: 15,
        minZoom: 1.0,
        maxZoom: 18.0,
        onTap: (point) => widget.onMapClick(point),
        onLongPress: (point) => widget.onMapLongClick(point));

    if (widget.onLocationUpdate != null)
      getCurrentLocation(
          statefulMapController: widget.statefulMapController,
          showMarker: widget.showLocationMarker);
    else if (widget.showLocationMarker)
      getCurrentLocation(
          statefulMapController: widget.statefulMapController,
          showMarker: widget.showLocationMarker);

    super.initState();
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(children: <Widget>[
        FlutterMap(
          mapController: widget.mapController,
          options: mapOptions,
          layers: [
            TileLayerOptions(
              wmsOptions: WMSTileLayerOptions(
                  baseUrl: "https://map.ir/shiveh?"
                      "&EXCEPTIONS=application/vnd.ogc.se_inimage"
                      "&width=256"
                      "&height=256"
                      "&srs=EPSG:3857"
                      "&bbox=%f,%f,%f,%f&x-api-key=${MapirMap.apiKey}",
                  layers: ['Shiveh:Shiveh'],
                  format: 'image/png',
                  version: '1.1.0',
                  otherParameters: {}),
            ),
            MarkerLayerOptions(markers: widget.statefulMapController.markers),
            PolylineLayerOptions(polylines: widget.statefulMapController.lines),
            PolygonLayerOptions(polygons: widget.statefulMapController.polygons)
          ],
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
                child: Wrap(
                  children: <Widget>[
                    Text('\u00a9Map \u00a9OpenStreetMap',
                        style: TextStyle(height: 5, fontSize: 12)),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(0, 0, 12, 0))),
        Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
                child: Image.asset(
                    'packages/flutter_map_sdk_v1/assets/images/logo.png',
                    width: 100,
                    height: 48),
                padding: EdgeInsets.fromLTRB(8, 0, 0, 8)))
      ])),
    );
  }

  void getCurrentLocation(
      {StatefulMapController statefulMapController,
      bool showMarker = false}) async {
    var location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    _locationData = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      widget.lastKnownLocation =
          LatLng(_locationData.latitude, _locationData.longitude);

      if (widget.onLocationUpdate != null)
        widget.onLocationUpdate(widget.lastKnownLocation);

      if (showMarker) {
        statefulMapController.addMarker(
            marker: Marker(
              point: widget.lastKnownLocation,
              builder: (ctx) => Container(
                child: Icon(
                  Icons.account_circle,
                  color: Colors.red.shade900,
                ),
              ),
            ),
            name: "currentLocation");

        statefulMapController.centerOnPoint(widget.lastKnownLocation);
      }
    });
  }
}
