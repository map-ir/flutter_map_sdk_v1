import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:map_controller/map_controller.dart';

import 'mapir.dart';

class MapView extends StatefulWidget {
  // double markerSize = 40.0;
  // List<Marker> markers;
  // AnchorAlign markerAnchorAlign = AnchorAlign.top;
  // IconData markerIcon = Icons.location_on;
  //
  // static PopupController popupLayerController = new PopupController();

  // List<LatLng> markerPoints = [
  //   LatLng(35.713904, 51.400909),
  // ];

  MapView({Key key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  MapOptions mapOptions = MapOptions(
    center: LatLng(35.713904, 51.400909),
    zoom: 14,
    minZoom: 1.0,
    maxZoom: 22.0,
    // plugins: [PopupMarkerPlugin()],
    // onTap: (_) => popupLayerController.hidePopup()
  );

  MapController mapController;
  StatefulMapController statefulMapController;
  StreamSubscription<StatefulMapControllerStateChange> sub;

  @override
  void initState() {
    mapController = MapController();
    statefulMapController = StatefulMapController(mapController: mapController);

    // wait for the controller to be ready before using it
    statefulMapController.onReady
        .then((_) => print("The map controller is ready"));

    /// [Important] listen to the changefeed to rebuild the map on changes:
    /// this will rebuild the map when for example addMarker or any method
    /// that mutates the map assets is called
    sub = statefulMapController.changeFeed.listen((change) => setState(() {}));

    statefulMapController.addStatefulMarker(
        name: "some marker",
        statefulMarker: StatefulMarker(
            height: 80.0,
            width: 120.0,
            state: <String, dynamic>{"showText": false},
            point: LatLng(35.713904, 51.400909),
            builder: (BuildContext context, Map<String, dynamic> state) {
              Widget w;
              final markerIcon = IconButton(
                  icon: const Icon(Icons.location_on),
                  onPressed: () => statefulMapController.mutateMarker(
                      name: "some marker",
                      property: "showText",
                      value: !(state["showText"] as bool)));
              if (state["showText"] == true) {
                w = Column(children: <Widget>[
                  markerIcon,
                  Container(
                      color: Colors.transparent,
                      child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text("map.ir", textScaleFactor: 1))),
                ]);
              } else
                w = markerIcon;

              return w;
            }));

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
          mapController: mapController,
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
            MarkerLayerOptions(markers: statefulMapController.markers),
            PolylineLayerOptions(polylines: statefulMapController.lines),
            PolygonLayerOptions(polygons: statefulMapController.polygons)
          ],
        ),
        // ...
      ])),
    );
  }
}
