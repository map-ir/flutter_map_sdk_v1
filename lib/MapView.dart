import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:map_controller/map_controller.dart';

import 'mapir.dart';

class MapView extends StatefulWidget {
  StatefulMapController statefulMapController;
  MapController mapController;

  MapView({Key key, this.mapController, this.statefulMapController})
      : super(key: key);

  // StatefulMapController _statefulMapController;
  //
  // void setController(StatefulMapController controller) {
  //   _statefulMapController = controller;
  // }

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  // MapController mapController;

  // StatefulMapController statefulMapController;
  StreamSubscription<StatefulMapControllerStateChange> sub;

  MapOptions mapOptions = MapOptions(
    center: LatLng(35.713949, 51.399086),
    zoom: 15,
    minZoom: 1.0,
    maxZoom: 18.0,
    // plugins: [PopupMarkerPlugin()],
    // onTap: (_) => popupLayerController.hidePopup()
  );

  // StatefulMapController getController() {
  //   return statefulMapController;
  // }

  @override
  void initState() {
    // wait for the controller to be ready before using it
    widget.statefulMapController.onReady
        .then((_) => print("The map controller is ready"));

    /// [Important] listen to the changefeed to rebuild the map on changes:
    /// this will rebuild the map when for example addMarker or any method
    /// that mutates the map assets is called
    sub = widget.statefulMapController.changeFeed
        .listen((change) => setState(() {}));

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
                      "&bbox=%f,%f,%f,%f&x-api-key=${Mapir.apiKey}",
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
        // ...
      ])),
    );
  }
}
