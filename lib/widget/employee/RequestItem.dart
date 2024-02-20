import 'package:flutter/material.dart';
// import 'package:rounded_letter/rounded_letter.dart';

class RequestItem extends StatelessWidget {
  String title;
  String subTitle;
  String leadLetter;
  String trailing1;
  String trailing2;
  final GestureTapCallback onTap;

  RequestItem({
  required  this.title,
  required  this.subTitle,
  required  this.leadLetter,
  required  this.trailing1,
  required  this.trailing2,
  required  this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: Card(
        elevation: 10,
        child: ListTile(
          onTap: onTap,
          dense: false,
          title: Text(title),
          subtitle: Text(subTitle),
          isThreeLine: false,
          leading: Text(leadLetter),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                trailing1,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .apply(fontSizeFactor: .3, color: Colors.black87),
              ),
              SizedBox(
                height: 4,
                width: 1,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 2, bottom: 2),
                  child: Text(
                    trailing2,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .apply(fontSizeFactor: .4),
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
