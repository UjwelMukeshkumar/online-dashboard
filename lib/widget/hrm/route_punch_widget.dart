import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowrpt/library/AppSctring.dart';
import 'package:glowrpt/library/DateFactory.dart';
import 'package:glowrpt/model/hrm/RoutPunchM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:glowrpt/widget/image_viewer.dart';
import 'package:glowrpt/widget/other/app_card.dart';
import 'package:provider/provider.dart';

class RoutePunchWidget extends StatefulWidget {
  RoutPunchM item;
   RoutePunchWidget(this.item, {Key? key}) : super(key: key);

  @override
  State<RoutePunchWidget> createState() => _RoutePunchWidgetState();
}

class _RoutePunchWidgetState extends State<RoutePunchWidget> {
   CompanyRepository? compRepo;

   String? bytesIn;
  String? bytesOut;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);

    loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: ExpansionTile(
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12,
          children: [
            Text("${widget.item.EmpName}"),
            Text(
              "On",
              style: Get.textTheme.caption,
            ),
            Text("${widget.item.Dt.tDateTodateTime.toDisplayDate}"),
          ],
        ),
        subtitle: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12,
          children: [
            Text("${widget.item.TotalKMPerDay} Km"),
            Text(
              "With",
              style: Get.textTheme.caption,
            ),
            Text("${widget.item.Type}"),
          ],
        ),
        children: [
          Row(
            children: [
              Expanded(
                  child: Column(

                    children: [
                      Text("${widget.item.PunchIN}"),
                      Text("${widget.item.PunchinKm}"),
                      Visibility(
                        child: InkWell(
                          onTap: ()=>Get.to(ImageViewer(bytesIn)),
                          child: Container(
                            margin: EdgeInsets.all(8),
                            // height: 80,
                            // width: 80,
                            // color: Colors.red,
                            child: Image.memory(Base64Decoder().convert(bytesIn ?? "")),
                          ),
                        ),
                        visible: isImageAvailableIn(widget.item.PunchInImage),
                      )
                    ],
                  )),
              Expanded(
                  child: Column(
                    children: [
                      Text("${widget.item.PunchOutTime}"),
                      Text("${widget.item.PunhOutKM}"),
                      Visibility(
                        child: InkWell(
                          onTap: ()=>Get.to(ImageViewer(bytesOut)),
                          child: Container(
                            margin: EdgeInsets.all(8),
                            // height: 80,
                            // width: 80,
                            // color: Colors.red,
                            child: Image.memory(Base64Decoder().convert(bytesOut ?? "")),
                          ),
                        ),
                        visible: isImageAvailableOut(widget.item.PunchOutImage),
                      )
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
  isImageAvailableIn(String img) =>img != null && img.length > 3 && bytesIn!=null;
  isImageAvailableOut(String img) =>img != null && img.length > 3 && bytesOut!=null;

  Future<void> loadImages() async {
    Future.wait([

      Serviece.loadImage(context: context,
        imageCode: widget.item.PunchInImage,
        orgId: compRepo!.getSelectedUser().orgId!),

      Serviece.loadImage(context: context,
          imageCode: widget.item.PunchOutImage,
          orgId: compRepo!.getSelectedUser().orgId!)

    ]).then((value){
      bytesIn=value.first;
      bytesOut=value.last;
      setState(() {

      });
    });

  }

}
