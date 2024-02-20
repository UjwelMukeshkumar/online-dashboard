import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLibrary{
  snapShotHandler(AsyncSnapshot snapshot){
    if(snapshot.hasError){
      return Text("Error ${snapshot.error}");
    }else{
      return Center(child: CupertinoActivityIndicator());
    }
  }
}
snapshotHandler(AsyncSnapshot snapshot){
  if(snapshot.hasError){
    return Text("Error ${snapshot.error}");
  }else{
    return Center(child: CupertinoActivityIndicator());
  }
}
