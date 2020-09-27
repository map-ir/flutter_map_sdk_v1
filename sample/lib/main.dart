import 'package:flutter/material.dart';
import 'package:flutter_map_sdk_v1/flutter_map_sdk_v1.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    MapirMap.init("نام پکیج برنامه شما", "کلید دسترسی");

    var mapController = MapController();
    var statefulMapController =
        StatefulMapController(mapController: mapController);

    var marker1 = Marker(
      width: 160.0,
      height: 160.0,
      point: LatLng(35.713949, 51.399086),
      builder: (ctx) => Container(child: Icon(Icons.location_on)),
      anchorPos: AnchorPos.align(AnchorAlign.center),
    );

    var points = List<LatLng>();
    points.add(LatLng(35.713949, 51.399086));
    points.add(LatLng(35.714345, 51.400304));
    points.add(LatLng(35.712942, 51.400486));

    statefulMapController.addLine(
        name: "sampleLine1",
        points: points,
        width: 5.0,
        color: Colors.blue,
        isDotted: true);

    statefulMapController.addPolygon(
        name: "samplePolygon1",
        points: points,
        color: Colors.blue,
        borderWidth: 5.0,
        borderColor: Colors.red);

    statefulMapController.addMarker(marker: marker1, name: "sampleMarker1");

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MapirMapView(
            mapController: mapController,
            statefulMapController: statefulMapController,
            onMapReady: () {},
            onMapClick: (location) {},
            onMapLongClick: (location) {},
            onLocationUpdate: (location) {},
            showLocationMarker: false));
  }
}
