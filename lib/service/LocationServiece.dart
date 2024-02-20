import 'dart:convert';
import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:glowrpt/model/location/DirectionM.dart';
import 'package:glowrpt/model/location/DistanceM.dart';
import 'package:glowrpt/model/location/SnapPointM.dart';
import 'package:glowrpt/model/route/PlannerRouteLoadM.dart';
import 'package:glowrpt/model/route/RouteEndM.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:place_picker/place_picker.dart';
import 'package:http/http.dart' as http;

class LocationServiece {
  Future<Position> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> getLocationName(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    String? localiti;
    String? subLocality;
    String? street;
    placemarks.forEach((element) {
      if (element.locality!.isNotEmpty) {
        localiti = element.locality;
      }
      if (element.subLocality!.isNotEmpty) {
        subLocality = element.subLocality!;
      }
      if (element.street!.isNotEmpty) {
        street = element.street;
      }
    });
    return localiti ?? subLocality ?? street ?? "";
  }

/*  Future<List<SnapPointM>> snapToRoute({String path}) async {
    // String path="-35.27801,149.12958|-35.28032,149.12907|-35.28099,149.12929|-35.28144,149.12984|-35.28194,149.13003|-35.28282,149.12956|-35.28302,149.12881|-35.28473,149.12836";
    String url =
        "https://roads.googleapis.com/v1/snapToRoads?path=$path&interpolate=true&key=${Constants.GOOGLE_MAP_API_KEY}";
    log("Url $url");
    var response = await http.get(Uri.parse(url));
    log("response ${response.body}");
    Map data = json.decode(response.body);
    return List<SnapPointM>.from(
        data["snappedPoints"].map((e) => SnapPointM.fromJson(e)));
  }*/

  Future<DistanceM> getDistanceMetrx(
      {required String origins, required String destinations}) async {
    String url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?key=${Constants.GOOGLE_MAP_API_KEY}&destinations=$destinations&origins=$origins";
    var response = await http.get(Uri.parse(url));
    
    // Map data = json.decode(response.body);
    Map<String,dynamic> data = json.decode(response.body);

    return DistanceM.fromJson(data);
  }

  Future<List<DirectionM>> getDirectionList(
      {required List<RouteHistory> routeHistory}) async {
    var response = await Future.wait(routeHistory.skip(1).map((e) {
      int index = routeHistory.indexOf(e);
      var bigin = routeHistory[index - 1];
      return getDirection(origin: bigin.empLatLng, destination: e.empLatLng);
    }).toList());
    return response;
  }

  Future<List<DirectionM>> getDirectionFromLatLng(
      [List<RouteDetailsBean>? orderedRoute]) async {
    try {
      var response = await Future.wait(orderedRoute!.skip(1).map((e) {
        int index = orderedRoute!.indexOf(e);
        var bigin = orderedRoute[index - 1];
        return getDirection(
            origin: bigin.EMP_LAT_LNG!, destination: e.EMP_LAT_LNG!);
      }).toList());
      return response;
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  // Future<List<DirectionM>> getDirectionFromLatLng(
  //     List<RouteDetailsBean>? orderedRoute) async {
  //   try {
  //     if (orderedRoute == null || orderedRoute.isEmpty) {
  //       // Handle the case when orderedRoute is null or empty.
  //       return [];
  //     }

  //     var response = await Future.wait(orderedRoute.skip(1).map((e) {
  //       int index = orderedRoute.indexOf(e);
  //       if (index <= 0) {
  //         // Handle the case when index is non-positive.
  //         return Future.error("Invalid index");
  //       }
  //       var begin = orderedRoute[index - 1];
  //       if (begin.EMP_LAT_LNG == null || e.EMP_LAT_LNG == null) {
  //         // Handle the case when EMP_LAT_LNG is null.
  //         return Future.error("EMP_LAT_LNG is null");
  //       }
  //       return getDirection(
  //           origin: begin.EMP_LAT_LNG!, destination: e.EMP_LAT_LNG!);
  //     }).toList());
  //     return [];
  //   } catch (e) {
  //     print(e.toString());
  //     // Rethrow the error or handle it as needed.
  //     throw e;
  //   }
  // }


  Future<DirectionM> getDirection({String? origin, String? destination}) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?key=${Constants.GOOGLE_MAP_API_KEY}&destination=$destination&origin=$origin";
    var response = await http.get(Uri.parse(url));
    log("Url ${url}");
    log("response ${response.body}");

    // Map data = json.decode(response.body);
    Map<String,dynamic> data = json.decode(response.body);
    return DirectionM.fromJson(data);
  }
}
