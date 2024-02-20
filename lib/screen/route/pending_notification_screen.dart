import 'package:flutter/material.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';

import '../../library/MyLibrary.dart';
import '../../model/route/PendingNotificationM.dart';

class PendingNotificationScreen extends StatefulWidget {
  @override
  State<PendingNotificationScreen> createState() =>
      _PendingNotificationScreenState();
}

class _PendingNotificationScreenState extends State<PendingNotificationScreen> {
  CompanyRepository? companyRepo;

  @override
  void initState() {
    
    super.initState();
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Notifications"),
      ),
      body: FutureBuilder(
        future: Serviece.getAllPendingNotification(
            context: context, api_key: companyRepo!.getSelectedApiKey()),
        builder: (context, AsyncSnapshot<List<PendingNotificationM>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, position) {
                  var item = snapshot.data![position];
                  return ListTile(
                    title: Text(item.EmpName),
                    subtitle: Text(item.RouteName),
                  );
                });
          }
          return snapshotHandler(snapshot);
        },
      ),
    );
  }
}
