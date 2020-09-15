import 'package:flutter/material.dart';
import 'package:flutter_map_sdk_v1/flutter_map_sdk_v1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Mapir.init(context,
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6Ijk5MzM4ZTg4ZDQ4OWRkYWU0MDViMjEwNWExMzA1YjZlYWFmZjQ5ZTkxZjk4NjYxMTk4ZDhiMDZiOTc2Mjc5MmRlOWFmMjQwN2IzNzVjNzNmIn0.eyJhdWQiOiI5NDQ5IiwianRpIjoiOTkzMzhlODhkNDg5ZGRhZTQwNWIyMTA1YTEzMDViNmVhYWZmNDllOTFmOTg2NjExOThkOGIwNmI5NzYyNzkyZGU5YWYyNDA3YjM3NWM3M2YiLCJpYXQiOjE1OTkzNzkwMDgsIm5iZiI6MTU5OTM3OTAwOCwiZXhwIjoxNjAxOTc0NjA4LCJzdWIiOiIiLCJzY29wZXMiOlsiYmFzaWMiXX0.ovF71cQXJ0PFu1rh_cLUCiXUEF5XpuxSMMI8DMcEJLJ8G-pMC9owTqX_7HmvB4dN_ZeF7VXzGouFzD2gfMgd6mvM6jHCH-T8HFH8aTER-rAXg2H8ZLqBaPNslpDLDZ-mHdBRvVCSThNtqlILeO8QJhCxP4-oO3Qcq4LTZ73x5OebZdGzcUGEiFHaJsSP2VYb2SAggkeQzMdmkxWFxXbtfu7X6tOfj-JFuNR3Dcdq6p95FIaE_WZBJ40kIxIvNaEumZG9z1jIc-t0Ba-huUFqBDn1Svrvp6RiSLMyshHYTtGlVDmyRKE_ojapGS2v-EJ6T7jQxeUSbNYAQhDdyhrVHQ");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'map.ir sample project',
      home: Center(
        child: MapView(),
      ),
    );
  }
}

// class MapPage extends StatefulWidget {
//   MapPage(GlobalKey<_MapPageState> key) : super(key: key);
//
//   @override
//   _MapPageState createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   static final List<LatLng> _points = [
//     LatLng(44.421, 10.404),
//     LatLng(45.683, 10.839),
//   ];

// static const _markerSize = 40.0;
// List<Marker> _markers;
//
// // Used to trigger showing/hiding of popups.
// final PopupController _popupLayerController = PopupController();
//
// @override
// void initState() {
//   super.initState();
//
//   _markers = _points
//       .map(
//         (LatLng point) => Marker(
//           point: point,
//           width: _markerSize,
//           height: _markerSize,
//           builder: (_) => Icon(Icons.location_on, size: _markerSize),
//           anchorPos: AnchorPos.align(AnchorAlign.top),
//         ),
//       )
//       .toList();
// }
//
// @override
// Widget build(BuildContext context) {
//   return FlutterMap(
//     options: new MapOptions(
//       zoom: 5.0,
//       center: _points.first,
//       plugins: [PopupMarkerPlugin()],
//       onTap: (_) => _popupLayerController
//           .hidePopup(), // Hide popup when the map is tapped.
//     ),
//     layers: [
//       TileLayerOptions(
//         urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//         subdomains: ['a', 'b', 'c'],
//       ),
//       PopupMarkerLayerOptions(
//         markers: _markers,
//         popupSnap: PopupSnap.top,
//         popupController: _popupLayerController,
//         popupBuilder: (BuildContext _, Marker marker) => ExamplePopup(marker),
//       ),
//     ],
//   );
// }
//
// void showPopupForFirstMarker() {
//   _popupLayerController.togglePopup(_markers.first);
// }
// }
