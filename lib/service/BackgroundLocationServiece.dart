import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class BackgroundLocationServiece with ChangeNotifier {
  var isTracking = false;

  startTracking() async {
    // final result = await Permission.locationAlways.request();
    final result = await Permission.location.request();
    if (result == PermissionStatus.granted) {
      if (isTracking) return;
      await BackgroundLocationTrackerManager.startTracking();
      isTracking = true;
      notifyListeners();
    }else{
      print("Location Not granded");
    }
  }

  stopTracking() async {
    if(isTracking){
      // await LocationDao().clear();
      // await _getLocations();
      await BackgroundLocationTrackerManager
          .stopTracking();
      isTracking = false;
      notifyListeners();
    }
  }
  Future<void> getTrackingStatus() async {
    isTracking = await BackgroundLocationTrackerManager.isTracking();
  notifyListeners();
  }
}
class Repo {
  static Repo? _instance;

  Repo._();

  factory Repo() => _instance ??= Repo._();

  Future<void> update(BackgroundLocationUpdateData data) async {
    final text = 'Location Updatex: Lat: ${data.lat} Lon: ${data.lon}';
    print(text); // ignore: avoid_print
    // sendNotification(text);
    // await LocationDao().saveLocation(data);
  }
}