import 'package:flutter/material.dart';
import 'package:glowrpt/util/DataProvider.dart';

class RouteListWedget extends StatefulWidget {
  RouteListWedget({Key? key}) : super(key: key);

  @override
  _RouteListWedgetState createState() => _RouteListWedgetState();
}

class _RouteListWedgetState extends State<RouteListWedget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: DataProvider.routes.length,
        itemBuilder: (context,position){
          var item=DataProvider.routes[position];
      return ListTile(title: Text(item),);
    });
  }
}