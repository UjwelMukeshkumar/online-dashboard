import 'package:flutter/material.dart';
import 'package:glowrpt/model/employe/EmpLoadM.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:get/get.dart';

class PendingTasksScreen extends StatefulWidget {
  EmpLoadM empLoadM;

  PendingTasksScreen({required this.empLoadM});

  @override
  _PendingTasksScreenState createState() => _PendingTasksScreenState();
}

class _PendingTasksScreenState extends State<PendingTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Tasks".tr),
      ),
      body: ListView.builder(
          itemCount: widget.empLoadM.PendingTaskList.length,
          itemBuilder: (context, index) {
            var item = widget.empLoadM.PendingTaskList[index];
            var textTheme = Theme.of(context).textTheme;
            return Card(
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "${item.Type}",
                          style: textTheme.bodyText1!.copyWith(height: 1.5),
                          children: [
                            TextSpan(text: " To ", style: textTheme.caption),
                            TextSpan(text: "${item.ToUserName}"),
                            TextSpan(text: " Start ", style: textTheme.caption),
                            TextSpan(
                                text:
                                    "${MyKey.displayDateFormat.format(MyKey.dateWebFormat.parse(item.StartTime))}"),
                            TextSpan(text: " For ", style: textTheme.caption),
                            TextSpan(text: "${item.SourceType}"),
                            TextSpan(
                                text: " Status ", style: textTheme.caption),
                            TextSpan(text: "${item.Status}"),
                          ]),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
