import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/route/RequestDetailsM.dart';

class FirebaseServiece {
  static sentPushNotification({
    required RequestDetailsM requestDetailsM,
    required String title,
    required String body,
    required String type,
  }) async {
    print("push notication dataPart${requestDetailsM.toJson()}");
    List<http.Response> response =
        await Future.wait(requestDetailsM.DeviceTokens.map((e) {
      var payLoad = jsonEncode({
        'to': e.DeviceToken,
        'data': requestDetailsM.toJson()
          ..remove("DeviceTokens")
          ..addAll({'type': type}),
        'notification': {
          'title': title,
          'body': '$body',
        },
      });
      var response = http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAANGLrneQ:APA91bFQ9Va1mdw34xT7VEMaaoLzW-YiWUHFA-WO4fs0-f5op7hxrL69hAOJaFi9FS5g_2PeGMoFsI_SUOrJ0kErNF6H5RgTQoz88Qj1yCKaRObZusvMjGRu0JRofKwlk8GeiRgrIOGG'
        },
        body: payLoad,
      );
      print("payLoad ${payLoad}");
      response.then((value) => print(value.body));
      return response;
    }));
    response.forEach((element) {
      print(element.body);
    });
  }
}

class PushNotificationType {
  static String LoginRequest = "LoginRequest";
  static String salesPurchaseEdit = "salesPurchaseEdit";
  static String addNewCustomer = "CV";
  static String changeRouteActiveState = "RT";
}
