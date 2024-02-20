import 'dart:async';

import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:glowrpt/library/AppSctring.dart';
import 'package:glowrpt/library/CollectionOperation.dart';
import 'package:glowrpt/model/employe/EmpLoadM.dart';
import 'package:glowrpt/model/employe/EmpPositionM.dart';
import 'package:glowrpt/model/location/DirectionM.dart' as dir;
import 'package:glowrpt/model/route/EmployeeM.dart';
import 'package:glowrpt/model/route/RouteM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/service/BackgroundLocationServiece.dart';
import 'package:glowrpt/service/LocationServiece.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../model/route/PlannerRouteLoadM.dart';
import '../../../util/TravelingSalesManProblem.dart';
import 'package:glowrpt/model/location/DistanceM.dart' as dist;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'employee_route_planner_report_screen2a.dart';

class BestRouteMapScreen extends StatefulWidget {
  List<RouteDetailsBean> routeDetails;
  RouteM item;
  EmpLoadM empLoadM;
  BestRouteMapScreen({
    Key? key,
    required this.routeDetails,
    required this.item,
    required this.empLoadM,
  }) : super(key: key);
  static const CameraPosition _glowsis = CameraPosition(
    target: LatLng(11.156487, 75.886731),
    zoom: 16,
  );

  @override
  State<BestRouteMapScreen> createState() => _BestRouteMapScreenState();
}

class _BestRouteMapScreenState extends State<BestRouteMapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CompanyRepository? companyrepo;

  // List<EmpPositionM> locationList;
  List<RouteDetailsBean> orderedRoute = [];

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  Map<MarkerId, Marker> markers = {};
  BackgroundLocationServiece? backgroundLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    companyrepo = Provider.of<CompanyRepository>(context, listen: false);
    loadLocation();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    backgroundLocation = Provider.of<BackgroundLocationServiece>(context);
    backgroundLocation!.getTrackingStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton.extended(
            onPressed: () {
              startRoute();
            },
            label: Text("Begin Route")),
      ),
      appBar: AppBar(
        title: Text("Recommended Route"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: BestRouteMapScreen._glowsis,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              polylines: Set<Polyline>.of(polylines.values),
              markers: markers.values.toSet(),
              zoomControlsEnabled: false,
            ),
          ),
          SizedBox(
            height: 80,
            child: PageView.builder(
                itemCount: orderedRoute.length,
                itemBuilder: (context, position) {
                  var item = orderedRoute[position];
                  return Card(
                    child: ListTile(
                      onTap: () async {
                        CameraPosition lastLocationCameraPosition =
                            CameraPosition(target: item.toLatLng, zoom: 16);
                        final GoogleMapController controller =
                            await _controller.future;
                        controller.animateCamera(CameraUpdate.newCameraPosition(
                            lastLocationCameraPosition));
                      },
                      title: Text("${item.CVName}"),
                      subtitle: Text("${item.Location}"),
                      trailing: Text("SLNO ${position + 1}"),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Future<void> loadLocation() async {
    List<RouteDetailsBean> selectedRoutes = [];
    var currentPosition = await LocationServiece().getPosition();
    var currentLatLng =
        LatLng(currentPosition.latitude, currentPosition.longitude);
    // _addMarker(currentLatLng, "Bining", BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),"Your Starting Location");
    CameraPosition lastLocationCameraPosition =
        CameraPosition(target: currentLatLng, zoom: 16);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(lastLocationCameraPosition));

    selectedRoutes.add(RouteDetailsBean(
      EMP_LAT_LNG: "${currentPosition.latitude},${currentPosition.longitude}",
      CVName: "Starting Point",
      Location: "Your Current Location",
    ));
    selectedRoutes.addAll(
        widget.routeDetails.where((element) => element.isSelected).toList());

    String joined = selectedRoutes.map((e) => e.EMP_LAT_LNG).join("|");
    dist.DistanceM distanceM = await LocationServiece()
        .getDistanceMetrx(destinations: joined, origins: joined);
    List<List<int>> distances = distanceM.rows
        .map((e) => e.elements.map((e) => e.distance.value).toList())
        .toList();
    List<int> solvedOrder = TravelingSalesManProblem().solve(distances);
    orderedRoute.clear();
    solvedOrder.forEach((e) {
      var item = selectedRoutes[e];
      orderedRoute.add(item);
      print("Locations ${item.CVName}");
      if (e == 0) {
        _addMarker(
            item.toLatLng,
            "${item.CVName}",
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            "${item.Location}");
      } else {
        _addMarker(item.toLatLng, item.CVName.toString(), BitmapDescriptor.defaultMarker,
            item.Location.toString());
      }
    });
    List<dir.DirectionM> directionList =
        await LocationServiece().getDirectionFromLatLng(orderedRoute);
    // distanceInMeter=directionList.map((e) => e.routes.first.getDistance).fold(0, (previousValue, element) => previousValue+element);
    directionList.forEach((e) {
      polylineCoordinates.addAll(e.routes.tryFirst?.polylinePoints ?? []);
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

    if (mounted) setState(() {});
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor,
      String description) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
        markerId: markerId,
        icon: descriptor,
        position: position,
        infoWindow: InfoWindow(title: id, snippet: description));
    markers[markerId] = marker;
  }

  Future<void> startRoute() async {
    showToast("Route Starting..");
    Position position = await LocationServiece().getPosition();
    String locationName = await LocationServiece()
        .getLocationName(LatLng(position.latitude, position.longitude));
    await Serviece.routeBeginEnd(
        apiKey: companyrepo!.getSelectedApiKey(),
        date: MyKey.getCurrentDate(),
        beginEnd: "B",
        empCode: companyrepo!.getSelectedUser().userCode!,
        latLng: "${position.latitude},${position.longitude}",
        routeId: widget.item.RouteID.toString(),
        location: locationName);
    backgroundLocation!.startTracking();

    Get.off(() => EmployeeRoutePlannerReportScreen2a(
          item: widget.item,
          empLoadM: widget.empLoadM,
        ));

    showToast("Route Started");
  }
}
