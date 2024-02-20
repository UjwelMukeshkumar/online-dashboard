import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/CounterM.dart';
import 'package:glowrpt/model/other/PagerM.dart';
import 'package:glowrpt/model/party/PartySearchM.dart';
import 'package:glowrpt/model/transaction/BillsM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:loadmore/loadmore.dart';
import 'package:provider/provider.dart';

class BillChooserScreen extends StatefulWidget {
  PartySearchM party;
  String billType;

  BillChooserScreen({
   required this.party,
   required this.billType,
  });

  @override
  _BillChooserScreenState createState() => _BillChooserScreenState();
}

class _BillChooserScreenState extends State<BillChooserScreen> {
   CompanyRepository? compRepo;

   PagerM? count;

  List<BillsM> heaDerList = [];
  bool hasMoreData = true;
  int pageNo = 0;

  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
    // updateLines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Bills"),
      ),
      body: Column(
        children: [
          Expanded(
            child: LoadMore(
              isFinish: !hasMoreData,
              onLoadMore: () async {
                pageNo++;
                var bool = await updateLines();
                return bool;
              },
              textBuilder: (statue) {
                if (statue == LoadMoreStatus.loading) {
                  return "Please wait";
                } else if (statue == LoadMoreStatus.nomore) {
                  return "No More Receipt";
                } else if (statue == LoadMoreStatus.fail) {
                  return "Failed";
                } else if (statue == LoadMoreStatus.idle) {
                  return "Ideal";
                }
                return "";
              },
              child: ListView.builder(
                  itemCount: heaDerList.length,
                  itemBuilder: (context, position) {
                    var item = heaDerList[position];
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          CheckboxListTile(
                            title: Row(
                              children: [
                                Text(item.documnet),
                                Text(
                                    "Amount :${MyKey.currencyFromat(item.TransAmount.toString())}"),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                            subtitle: Row(
                              children: [
                                Text(item.dateText),
                                Text(
                                    "Balance :${MyKey.currencyFromat(item.TransBalance.toString())}"),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                            onChanged: (value) {
                              if (value!) {
                                item.reciptAmount =
                                    item.TransBalance.toString();
                              } else {
                                item.reciptAmount = "0";
                              }
                              setState(() {
                                item.isChecked = value;
                              });
                            },
                            value: item.isChecked,
                          ),
                          Visibility(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, bottom: 16, right: 16),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Receipt Amount",
                                    border: textFieldBorder),
                                keyboardType: TextInputType.number,
                                onChanged: (text) {
                                  setState(() {
                                    item.reciptAmount = text;
                                  });
                                },
                                initialValue: item.reciptAmount,
                                validator: (text) {
                                  return (double.tryParse(text!) ?? 0) >
                                          (double.tryParse(item.reciptAmount.toString()) ??
                                              0)
                                      ? "Amount should be less than bill amount"
                                      : null;
                                },
                                autovalidateMode: AutovalidateMode.always,
                              ),
                            ),
                            visible: item.isChecked,
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
          ListTile(
              title: Text("Number of items"),
              trailing: Text(
                  "${heaDerList.where((element) => element.isChecked).length}")),
          ListTile(
              title: Text("Total Amount"),
              trailing: Text(
                  "${MyKey.currencyFromat(heaDerList.where((element) => element.isChecked).map((e) => double.tryParse(e.reciptAmount.toString()) ?? 0).fold(0.0, (previousValue, element) => previousValue + element).toString())}")),
          FractionallySizedBox(
              widthFactor: 1,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                        context,
                        heaDerList
                            .where((element) => element.isChecked)
                            .toList());
                  },
                  child: Text("Submit")))
        ],
      ),
    );
  }

  Future<bool> updateLines() async {
    var response = await Serviece.getBills(
        context: context,
        api_key: compRepo!.getSelectedApiKey(),
        Code: widget.party.code,
        DocType: widget.billType,
        pageNumber: pageNo.toString());
    var bills =
        List<BillsM>.from(response["List"].map((x) => BillsM.fromJson(x)));
    count = List<PagerM>.from(response["Count"].map((x) => PagerM.fromJson(x)))
        .first;
    if (bills != null) {
      // hasMoreData = bills.length > 0;
      hasMoreData = count!.PageNo > pageNo;
      heaDerList.addAll(bills);
    } else {
      return false;
    }
    setState(() {});
    return hasMoreData;
  }
}
