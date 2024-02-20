import 'dart:async';
import 'dart:developer';

import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:glowrpt/library/AppSctring.dart';
import 'package:glowrpt/library/CollectionOperation.dart';
import 'package:glowrpt/model/location/DirectionM.dart' as direction;
import 'package:glowrpt/model/location/SnapPointM.dart';
import 'package:glowrpt/model/route/RouteEndM.dart';
import 'package:glowrpt/screen/route/route_map_screen.dart';
import 'package:glowrpt/service/LocationServiece.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:collection/collection.dart';

class RouteSummaryScreen extends StatefulWidget {
  RouteEndM routeEndM;
   RouteSummaryScreen({Key? key,required this.routeEndM}) : super(key: key);

  @override
  _RouteSummaryScreenState createState() => _RouteSummaryScreenState();
}

class _RouteSummaryScreenState extends State<RouteSummaryScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // RouteEndM routeEndM;
  static CameraPosition? _glowsis;

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  Map<MarkerId, Marker> markers = {};

  double distanceInMeter=0.0;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route Summary"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _glowsis!,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              polylines: Set<Polyline>.of(polylines.values),
              markers: markers.values.toSet(),
              zoomControlsEnabled: false,
            ),
          ),
          Card(
            child: Column(
              children: [
                Text("Summary",style: Get.textTheme.titleLarge),
                ListTile(
                  title: Text("Total Distance"),
                  trailing: Text("${distanceInMeter/1000} Km"),
                ),
                ListTile(
                  title: Text("Claimable amount"),
                  trailing: Text("Rs ${distanceInMeter*widget.routeEndM.routeDetails.first.kmInstive/1000}"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> loadData() async {
    // routeEndM = routeEndMFromJson(routeSampleData);

    var routeHistory = widget.routeEndM.routeHistory;
    if (widget.routeEndM.routeDetails.tryFirst != null) {
      var biginModel = widget.routeEndM.routeDetails.first;
      var bigin = biginModel.routeBeginPlot;
      routeHistory.insert(
          0,
          RouteHistory(
              text: biginModel.beginText,
              cvName: "Starting Point",
              empLatLng: bigin));

      _glowsis = CameraPosition(
        target: LatLng(
            bigin.split(",").first.toDouble, bigin.split(",").last.toDouble),
        zoom: 12,
      );
      var routeEnd = biginModel.routeEndPlot;
      routeHistory.add(RouteHistory(
          text: biginModel.endText, cvName: "End Point", empLatLng: routeEnd));
    }
    routeHistory.forEach((e) {
      _addMarker(e.toLatLng(), e,
          BitmapDescriptor.defaultMarker);
    });
    List<direction.DirectionM> directionList=await LocationServiece().getDirectionList(routeHistory: routeHistory);
     distanceInMeter=directionList.map((e) => e.routes.first.getDistance).fold(0, (previousValue, element) => previousValue+element);
    directionList.forEach((e) {
      polylineCoordinates.addAll(e.routes.tryFirst?.polylinePoints??[]);
    });
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates,
        endCap: Cap.roundCap,
        startCap: Cap.roundCap,
        width: 3,
        jointType: JointType.round);
    polylines[id] = polyline;
    setState(() {});

  }

  _addMarker(LatLng position, RouteHistory routeHistory, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(routeHistory.empLatLng);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position,infoWindow: InfoWindow(
      title: routeHistory.cvName,
      snippet: routeHistory.text
    ));
    markers[markerId] = marker;
  }

  @override
  void dispose() {
    _controller.future.then((value) => value.dispose());
    super.dispose();
  }
}

String routeSampleData = '''
{
      "RouteDetails": [
      {
        "RouteBeginPlot": "11.25824,75.7804467",
        "BeginText": "Started at 7:26PM Loacation : Kozhikode",
        "RouteEndPlot": "11.2523538,75.783366",
        "EndText": "Ended at 11:26PM Loacation : Kozhikode",
        "KMInstive": 20
      }
    ],
    "RouteHistory": [
      {
        "CVCode": "14259",
        "CVName": "Apple POS Customer",
        "Text": "Punched at 7:26PM Loacation : Kozhikode",
        "EMP_LAT_LNG": "11.2390135,75.7866101"
      },
      {
        "CVCode": "54545",
        "CVName": "abu backer",
        "Text": "Punched at 7:26PM Loacation : Kozhikode",
        "EMP_LAT_LNG": "11.2399721,75.7863192"
      }
    ]
}

''';
