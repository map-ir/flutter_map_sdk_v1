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
    Mapir.init(context,
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6Ijk5MzM4ZTg4ZDQ4OWRkYWU0MDViMjEwNWExMzA1YjZlYWFmZjQ5ZTkxZjk4NjYxMTk4ZDhiMDZiOTc2Mjc5MmRlOWFmMjQwN2IzNzVjNzNmIn0.eyJhdWQiOiI5NDQ5IiwianRpIjoiOTkzMzhlODhkNDg5ZGRhZTQwNWIyMTA1YTEzMDViNmVhYWZmNDllOTFmOTg2NjExOThkOGIwNmI5NzYyNzkyZGU5YWYyNDA3YjM3NWM3M2YiLCJpYXQiOjE1OTkzNzkwMDgsIm5iZiI6MTU5OTM3OTAwOCwiZXhwIjoxNjAxOTc0NjA4LCJzdWIiOiIiLCJzY29wZXMiOlsiYmFzaWMiXX0.ovF71cQXJ0PFu1rh_cLUCiXUEF5XpuxSMMI8DMcEJLJ8G-pMC9owTqX_7HmvB4dN_ZeF7VXzGouFzD2gfMgd6mvM6jHCH-T8HFH8aTER-rAXg2H8ZLqBaPNslpDLDZ-mHdBRvVCSThNtqlILeO8QJhCxP4-oO3Qcq4LTZ73x5OebZdGzcUGEiFHaJsSP2VYb2SAggkeQzMdmkxWFxXbtfu7X6tOfj-JFuNR3Dcdq6p95FIaE_WZBJ40kIxIvNaEumZG9z1jIc-t0Ba-huUFqBDn1Svrvp6RiSLMyshHYTtGlVDmyRKE_ojapGS2v-EJ6T7jQxeUSbNYAQhDdyhrVHQ");

    var statefulMapController =
        StatefulMapController(mapController: MapController());

    statefulMapController.addStatefulMarker(
        name: "sampleMarker1",
        statefulMarker: StatefulMarker(
            height: 80.0,
            width: 120.0,
            state: <String, dynamic>{"showText": false},
            point: LatLng(35.713949, 51.399086),
            builder: (BuildContext context, Map<String, dynamic> state) {
              Widget w;
              final markerIcon = IconButton(
                  icon: const Icon(Icons.location_on),
                  onPressed: () => statefulMapController.mutateMarker(
                      name: "sampleMarker1",
                      property: "showText",
                      value: !(state["showText"] as bool)));
              if (state["showText"] == true) {
                w = Column(children: <Widget>[
                  markerIcon,
                  Container(
                      color: Colors.transparent,
                      child: Text("sampleMarker1", textScaleFactor: 1))
                ]);
              } else
                w = markerIcon;

              return w;
            }));

    print(statefulMapController.zoom);
    statefulMapController.zoomIn();
    statefulMapController.zoomOut();
    statefulMapController.zoomTo(12);

    print(statefulMapController.center);
    statefulMapController.centerOnPoint(LatLng(35.714345, 51.400304));

    // AnchorPos pos = <AnchorAlign dynamic>{ anchor:  AnchorAlign.top};
    // pos.value = AnchorAlign.top;

    statefulMapController.addMarker(
        marker: Marker(
            point: LatLng(35.714345, 51.400304), width: 30.0, height: 30.0),
        name: "testMarker");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapView(statefulMapController: statefulMapController),
    );
  }
}
