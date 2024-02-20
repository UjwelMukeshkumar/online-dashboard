import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  static const String routeName = '/notification';

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
   CompanyRepository? compRepo;

  List<String>? list;

  @override
  void initState() {
    
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notification'),
        ),
        body: list != null
            ? ListView.builder(
                itemCount: list!.length,
                itemBuilder: (context, position) {
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                        title: Html(data: list![position],)),
                        // title: Text("sdf"),)
                  );
                })
            : Center(
                child: CupertinoActivityIndicator(),
              ));
  }

  Future<void> loadData() async {
    list = await Serviece.getNotification(
        context: context, apiKey: compRepo!.getSelectedApiKey());
    setState(() {});
  }
}
