import 'package:flutter_test/flutter_test.dart';
import 'package:glowrpt/library/DateFactory.dart';
import 'package:glowrpt/model/location/DistanceM.dart';
import 'package:glowrpt/model/transaction/DocSaveM.dart';

void main() {
  DistanceM disstanceMetrics = distanceMFromJson(jsonData);
  showShotast(3, disstanceMetrics);
}

showShotast(int position, DistanceM distanceM) {
  List<int> exceptIndex = [];
  distanceM.rows.forEach((e) {

    var remainItem = e.elements
    .skipWhile((value) => value.distance.value==0)
        .skipWhile((value) => exceptIndex.contains(distanceM.rows.indexOf(e))).toList();


    if(remainItem.isNotEmpty){
      int lowestValue=remainItem.first.distance.value;
      int index = e.elements.indexOf(remainItem.first);

      remainItem
          .forEach((element) {
        // int currentIndex=e.elements.indexOf(element);
        if(element.distance.value<lowestValue){
          lowestValue=element.distance.value;
          index = e.elements.indexOf(element);
        }
      });
      exceptIndex.add(index);
    }

  });
  exceptIndex.forEach((element) {
    print("$element =${distanceM.originAddresses[element]}");
  });
}

String jsonData = '''

{
    "destination_addresses": [
        "4V6M+VR8, Chelari, Kerala 673633, India",
        "2WPQ+884, Kakkad, Kerala 676306, India",
        "2WV5+PH6, Elumbattiyil Rd, Chemmad, Kerala 676306, India",
        "3W9F+73G, VK Padi, Kerala 676305, India",
        "3XP3+556, Kunnumpuram, Kerala 676305, India"
    ],
    "origin_addresses": [
        "4V6M+VR8, Chelari, Kerala 673633, India",
        "2WPQ+884, Kakkad, Kerala 676306, India",
        "2WV5+PH6, Elumbattiyil Rd, Chemmad, Kerala 676306, India",
        "3W9F+73G, VK Padi, Kerala 676305, India",
        "3XP3+556, Kunnumpuram, Kerala 676305, India"
    ],
    "rows": [
        {
            "elements": [
                {
                    "distance": {
                        "text": "1 m",
                        "value": 0
                    },
                    "duration": {
                        "text": "1 min",
                        "value": 0
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "13.3 km",
                        "value": 13322
                    },
                    "duration": {
                        "text": "22 mins",
                        "value": 1335
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "12.6 km",
                        "value": 12579
                    },
                    "duration": {
                        "text": "24 mins",
                        "value": 1445
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "8.5 km",
                        "value": 8538
                    },
                    "duration": {
                        "text": "15 mins",
                        "value": 895
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "13.9 km",
                        "value": 13855
                    },
                    "duration": {
                        "text": "23 mins",
                        "value": 1385
                    },
                    "status": "OK"
                }
            ]
        },
        {
            "elements": [
                {
                    "distance": {
                        "text": "16.1 km",
                        "value": 16136
                    },
                    "duration": {
                        "text": "27 mins",
                        "value": 1604
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "1 m",
                        "value": 0
                    },
                    "duration": {
                        "text": "1 min",
                        "value": 0
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "8.1 km",
                        "value": 8135
                    },
                    "duration": {
                        "text": "16 mins",
                        "value": 968
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "8.8 km",
                        "value": 8754
                    },
                    "duration": {
                        "text": "13 mins",
                        "value": 800
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "10.7 km",
                        "value": 10740
                    },
                    "duration": {
                        "text": "18 mins",
                        "value": 1065
                    },
                    "status": "OK"
                }
            ]
        },
        {
            "elements": [
                {
                    "distance": {
                        "text": "9.8 km",
                        "value": 9781
                    },
                    "duration": {
                        "text": "19 mins",
                        "value": 1167
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "5.6 km",
                        "value": 5560
                    },
                    "duration": {
                        "text": "12 mins",
                        "value": 748
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "1 m",
                        "value": 0
                    },
                    "duration": {
                        "text": "1 min",
                        "value": 0
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "4.8 km",
                        "value": 4820
                    },
                    "duration": {
                        "text": "10 mins",
                        "value": 589
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "8.7 km",
                        "value": 8678
                    },
                    "duration": {
                        "text": "18 mins",
                        "value": 1055
                    },
                    "status": "OK"
                }
            ]
        },
        {
            "elements": [
                {
                    "distance": {
                        "text": "8.3 km",
                        "value": 8261
                    },
                    "duration": {
                        "text": "15 mins",
                        "value": 917
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "4.9 km",
                        "value": 4854
                    },
                    "duration": {
                        "text": "8 mins",
                        "value": 459
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "4.7 km",
                        "value": 4706
                    },
                    "duration": {
                        "text": "11 mins",
                        "value": 632
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "1 m",
                        "value": 0
                    },
                    "duration": {
                        "text": "1 min",
                        "value": 0
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "5.4 km",
                        "value": 5387
                    },
                    "duration": {
                        "text": "8 mins",
                        "value": 508
                    },
                    "status": "OK"
                }
            ]
        },
        {
            "elements": [
                {
                    "distance": {
                        "text": "13.4 km",
                        "value": 13422
                    },
                    "duration": {
                        "text": "23 mins",
                        "value": 1405
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "6.7 km",
                        "value": 6670
                    },
                    "duration": {
                        "text": "11 mins",
                        "value": 650
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "10.2 km",
                        "value": 10238
                    },
                    "duration": {
                        "text": "20 mins",
                        "value": 1198
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "5.6 km",
                        "value": 5624
                    },
                    "duration": {
                        "text": "13 mins",
                        "value": 764
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "1 m",
                        "value": 0
                    },
                    "duration": {
                        "text": "1 min",
                        "value": 0
                    },
                    "status": "OK"
                }
            ]
        }
    ],
    "status": "OK"
}

''';
