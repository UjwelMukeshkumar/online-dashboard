import 'dart:async';

import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:glowrpt/library/AppSctring.dart';
import 'package:glowrpt/model/employe/EmpPositionM.dart';
import 'package:glowrpt/model/route/EmployeeM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class RouteMapScreen extends StatefulWidget {
  RouteEmployeeM selectedEmployee;

  RouteMapScreen({Key? key, required this.selectedEmployee}) : super(key: key);
  static const CameraPosition _glowsis = CameraPosition(
    target: LatLng(11.156487, 75.886731),
    zoom: 16,
  );

  @override
  State<RouteMapScreen> createState() => _RouteMapScreenState();
}

class _RouteMapScreenState extends State<RouteMapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CompanyRepository? companyrepo;

  List<EmpPositionM>? locationList;

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  Map<MarkerId, Marker> markers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    companyrepo = Provider.of<CompanyRepository>(context, listen: false);
    loadLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => RouteMapScreen(
                        selectedEmployee: widget.selectedEmployee,
                      )));
        },
        child: Icon(Icons.refresh),
      ),
      appBar: AppBar(
        title: Text("Employee Route"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: RouteMapScreen._glowsis,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              polylines: Set<Polyline>.of(polylines.values),
              markers: markers.values.toSet(),
              zoomControlsEnabled: false,
            ),
          ),
          if (locationList != null && locationList!.length > 0)
            DraggableBottomSheet(
              minExtent: 80,
              useSafeArea: false,
              curve: Curves.easeIn,
              previewWidget: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.black87,
                      height: 3,
                      width: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("More Details", style: Get.textTheme.titleLarge),
                  ],
                ),
              ),
              expandedWidget: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.black87,
                      height: 3,
                      width: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("More Details", style: Get.textTheme.titleLarge),
                    Expanded(
                      child: ListView.builder(
                          itemCount: locationList!.length,
                          itemBuilder: (context, position) {
                            var item = locationList![position];
                            return ListTile(
                              onTap: () async {
                                CameraPosition lastLocationCameraPosition =
                                    CameraPosition(
                                        target: LatLng(item.lat, item.lan),
                                        zoom: 20);
                                final GoogleMapController controller =
                                    await _controller.future;
                                controller.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        lastLocationCameraPosition));
                              },
                              title: Text("${item.createdDate}"),
                              trailing: Text("${item.accuracy}"),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              backgroundWidget: Container(),
              duration: const Duration(milliseconds: 10),
              maxExtent: MediaQuery.of(context).size.height * 0.8,
              onDragging: (pos) {},
            )
        ],
      ),
    );
  }

  Future<void> loadLocation() async {
    locationList = await Serviece.getRoutes(
      context: context,
      api_key: companyrepo!.getSelectedApiKey(),
      fromdate: MyKey.getCurrentDate(),
      Todate: MyKey.getCurrentDate(),
      EmpCode: widget.selectedEmployee.EmpCode.toString(),
    );
    polylineCoordinates.clear();
    if (locationList!.length > 0) {
      locationList!.forEach((e) {
        polylineCoordinates.add(e.toLatLng());
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
      CameraPosition lastLocationCameraPosition = CameraPosition(
          target: LatLng(locationList!.last.lat, locationList!.last.lan),
          zoom: 16);
      _addMarker(locationList!.first.toLatLng(), "origin",
          BitmapDescriptor.defaultMarker);

      /// destination marker
      _addMarker(locationList!.last.toLatLng(), "destination",
          BitmapDescriptor.defaultMarkerWithHue(90));

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
          CameraUpdate.newCameraPosition(lastLocationCameraPosition));
      setState(() {});
    } else {
      showToast("Tranked position not available for this user");
    }
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }
}
