// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:glowrpt/model/manager/RequestsM.dart';
// import 'package:glowrpt/repo/Provider.dart';
// import 'package:glowrpt/util/MyKey.dart';
// import 'package:glowrpt/util/Serviece.dart';
// import 'package:glowrpt/widget/image_viewer.dart';
// import 'package:provider/provider.dart';
// import 'package:toast/toast.dart';

// import '../util/Constants.dart';

// class RequestWidget extends StatefulWidget {
//   RequestsM item;
//   GestureTapCallback onTap;

//   RequestWidget({required this.item, required this.onTap});

//   @override
//   State<RequestWidget> createState() => _RequestWidgetState();
// }

// class _RequestWidgetState extends State<RequestWidget> {
//   CompanyRepository? compRepo;
//   var bytes;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     compRepo = Provider.of<CompanyRepository>(context, listen: false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     var textTheme = Theme.of(context).textTheme;
//     // return Text("Hello");
//     return Stack(
//       children: [
//         Container(
//           padding: EdgeInsets.only(bottom: 16),
//           margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//           decoration:
//               containerDecoration.copyWith(color: AppColor.backgroundSemiDark),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   widget.item.Request,
//                   style: textTheme.subtitle1,
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "On ",
//                     style: textTheme.caption,
//                   ),
//                   Text(
//                     "${MyKey.getDispayDateFromWb(widget.item.CreatedDate)}",
//                     style: textTheme.caption,
//                   )
//                 ],
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                       child: ListTile(
//                     title: Text("Name".tr),
//                     subtitle: Text(
//                       widget.item.EmpName,
//                       style: textTheme.headline6!.copyWith(fontSize: 16),
//                     ),
//                   )),
//                   Container(
//                     height: 50,
//                     width: 1,
//                     color: Colors.black12,
//                   ),
//                   Expanded(
//                       child: ListTile(
//                     title: Text("Status".tr),
//                     subtitle: Text(widget.item.ApprovalLevel ?? "",
//                         style: textTheme.headline6!.copyWith(fontSize: 16)),
//                   )),
//                 ],
//               ),
//               Text(widget.item.remarksText ?? ""),
//               Visibility(
//                 child: Padding(
//                   padding: const EdgeInsets.all(6.0),
//                   child: Text(
//                     widget.item.Reason ?? "",
//                     style: textTheme.caption,
//                   ),
//                 ),
//                 visible: (widget.item.Reason ?? "").length > 0,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     labelText: "Remarks".tr,
//                     border: textFieldBorder,
//                   ),
//                   onChanged: (text) {
//                     widget.item.Remarks = text;
//                   },
//                   minLines: 1,
//                   maxLines: 4,
//                 ),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                       child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: OutlinedButton(
//                       onPressed: () => approveReject(false, widget.item),
//                       child: Text(
//                         "Reject".tr,
//                         style: TextStyle(color: AppColor.negativeRed),
//                       ),
//                     ),
//                   )),
//                   Expanded(
//                       child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: OutlinedButton(
//                         onPressed: () => approveReject(true, widget.item),
//                         child: Text(
//                           "Approve".tr,
//                           style: TextStyle(color: AppColor.positiveGreen),
//                         )),
//                   )),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           child: Visibility(
//             child: InkWell(
//               onTap: () => Get.to(ImageViewer(bytes)),
//               child: Container(
//                 height: 80,
//                 width: 80,
//                 // color: Colors.red,
//                 child: Image.memory(Base64Decoder().convert(bytes ?? "")),
//               ),
//             ),
//           //  visible: isImageAvailable(widget.item),
//           ),
//           right: 16,
//           top: 20,
//         )
//       ],
//     );
//   }

// //   Future<void> approveReject(bool isApprove, RequestsM item) async {
// //     if (!isApprove && (item.Remarks == null || item.Remarks!.isEmpty)) {
// //       Toast.show("Please Enter Remarks");
// //       return;
// //     }
// //     var response = await Serviece.approveReject(
// //         context: context,
// //         api_key: compRepo!.getSelectedApiKey(),
// //         remarks: item.Remarks ?? "",
// //         RequestId: item.RequestID.toString(),
// //         RequestType: item.RequestType,
// //         Approved: isApprove ? "1" : "1",
// //         Branchrequest: item.BranchReuest,
// //         OrgId: compRepo!.getPrimaryUser()!.orgId.toString());
// //     if (response != null) {
// //       Toast.show(isApprove ? "Approved" : "Rejected");
// //       widget.onTap();
// //     }
// //   }

// //   isImageAvailable(RequestsM item) =>
// //       item.Img != null && item.Img.length > 3 && bytes != null;
// // }
