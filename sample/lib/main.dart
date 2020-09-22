import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map_sdk_v1/flutter_map_sdk_v1.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    MapirMap.init(context,
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6Ijk5MzM4ZTg4ZDQ4OWRkYWU0MDViMjEwNWExMzA1YjZlYWFmZjQ5ZTkxZjk4NjYxMTk4ZDhiMDZiOTc2Mjc5MmRlOWFmMjQwN2IzNzVjNzNmIn0.eyJhdWQiOiI5NDQ5IiwianRpIjoiOTkzMzhlODhkNDg5ZGRhZTQwNWIyMTA1YTEzMDViNmVhYWZmNDllOTFmOTg2NjExOThkOGIwNmI5NzYyNzkyZGU5YWYyNDA3YjM3NWM3M2YiLCJpYXQiOjE1OTkzNzkwMDgsIm5iZiI6MTU5OTM3OTAwOCwiZXhwIjoxNjAxOTc0NjA4LCJzdWIiOiIiLCJzY29wZXMiOlsiYmFzaWMiXX0.ovF71cQXJ0PFu1rh_cLUCiXUEF5XpuxSMMI8DMcEJLJ8G-pMC9owTqX_7HmvB4dN_ZeF7VXzGouFzD2gfMgd6mvM6jHCH-T8HFH8aTER-rAXg2H8ZLqBaPNslpDLDZ-mHdBRvVCSThNtqlILeO8QJhCxP4-oO3Qcq4LTZ73x5OebZdGzcUGEiFHaJsSP2VYb2SAggkeQzMdmkxWFxXbtfu7X6tOfj-JFuNR3Dcdq6p95FIaE_WZBJ40kIxIvNaEumZG9z1jIc-t0Ba-huUFqBDn1Svrvp6RiSLMyshHYTtGlVDmyRKE_ojapGS2v-EJ6T7jQxeUSbNYAQhDdyhrVHQ");

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

    // statefulMapController.addStatefulMarker(
    //     name: "sampleMarker1",
    //     statefulMarker: StatefulMarker(
    //         height: 80.0,
    //         width: 120.0,
    //         state: <String, dynamic>{"showText": false},
    //         point: LatLng(35.713949, 51.399086),
    //         builder: (BuildContext context, Map<String, dynamic> state) {
    //           Widget w;
    //           final markerIcon = IconButton(
    //               icon: const Icon(Icons.location_on),
    //               onPressed: () => statefulMapController.mutateMarker(
    //                   name: "sampleMarker1",
    //                   property: "showText",
    //                   value: !(state["showText"] as bool)));
    //           if (state["showText"] == true) {
    //             w = Column(children: <Widget>[
    //               markerIcon,
    //               Container(
    //                   color: Colors.transparent,
    //                   child: Text("sampleMarker1", textScaleFactor: 1))
    //             ]);
    //           } else
    //             w = markerIcon;
    //
    //           return w;
    //         }));
    //
    // var points = List<LatLng>();
    // points.add(LatLng(35.713949, 51.399086));
    // points.add(LatLng(35.714345, 51.400304));
    // points.add(LatLng(35.712942, 51.400486));
    //
    // statefulMapController.addLine(
    //     name: "sampleLine1",
    //     points: points,
    //     width: 5.0,
    //     color: Colors.blue,
    //     isDotted: true);
    //
    // statefulMapController.addPolygon(
    //     name: "samplePolygon1",
    //     points: points,
    //     color: Colors.blue,
    //     borderWidth: 5.0,
    //     borderColor: Colors.red);

    statefulMapController.addMarker(marker: marker1, name: "s1");

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MapirMapView(
            mapController: mapController,
            statefulMapController: statefulMapController,
            onMapReady: () {
              loadData(statefulMapController);
            },
            onMapClick: (location) {
              Fluttertoast.showToast(
                  msg:
                      "نقشه را کلیک کردید. \n${location.latitude}, ${location.longitude}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
            onMapLongClick: (location) {
              Fluttertoast.showToast(
                  msg:
                      "نقشه را لانگ کلیک کردید. \n${location.latitude}, ${location.longitude}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
            onLocationUpdate: (location) {
              Fluttertoast.showToast(
                  msg:
                      "موقعیت جدید: \n${location.latitude}, ${location.longitude}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
            showLocationMarker: true));
  }

  void loadData(statefulMapController) async {
    print("Loading geojson data");
    final data = await rootBundle.loadString('assets/test.geojson');
    await statefulMapController.fromGeoJson(data,
        markerIcon: Icon(Icons.local_airport), verbose: true);
  }
}
