import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/model/other/LedgerHeadderM.dart';
import 'package:glowrpt/model/other/LedgerM.dart';
import 'package:glowrpt/screen/create_new_account.dart';
import 'package:glowrpt/screen/transaction_details.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:intl/intl.dart';
import 'package:loadmore/loadmore.dart';
import 'package:provider/provider.dart';
import 'package:glowrpt/library/DateFactory.dart';

import '../create_new_party.dart';

class PartyTab extends StatefulWidget {
  String type;
  String title;
  ValueChanged<LedgerHeadderM>? valueChanged;

  PartyTab(
    this.type, {
    this.valueChanged,
    required this.title,
  });

  @override
  _PartyTabState createState() => _PartyTabState();
}

class _PartyTabState extends State<PartyTab>
    with AutomaticKeepAliveClientMixin {
  CompanyRepository? companyRepo;

  List<LedgerM> ledgersList = [];

  LedgerHeadderM? ledgerHeadder;

  List<LedgerM>? fullList;

  String query = "";

  bool hasMoreData = true;

  String? fromDate;

  String? todate;
  int pageNo = 0;

  @override
  void initState() {
    super.initState();
    companyRepo = Provider.of<CompanyRepository>(context, listen: false);

    // getLedgers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (text) async {
                  print("One submit");
                  query = text.toLowerCase();
                  pageNo = 0;
                  ledgersList.clear();
                  hasMoreData = true;
                  setState(() {});
                  // await getLedgers();
                },
                decoration: InputDecoration(
                    labelText: "Search",
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColor.title,
                    ),
                    suffixIcon: InkWell(
                      onTap: () async {
                        var data;
                        if (widget.type == "A") {
                          data = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateNewAccount()));
                        } else {
                          data = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateNewParty(
                                        type: widget.type,
                                        title: getStringFromType(),
                                      )));
                        }

                        if (data == true) {
                          // getLedgers();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add,
                              color: AppColor.title,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Create New ${getStringFromType()}",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius:
                                BorderRadius.all(Radius.circular(22))),
                      ),
                    )),
              )),
            ],
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LoadMore(
            onLoadMore: () async {
              pageNo++;
              var bool = await getLedgers();
              print("page No  ************************************************ "
                  "$pageNo $bool");
              return bool;
              ;
            },
            isFinish: !hasMoreData,
            textBuilder: (statue) {
              if (statue == LoadMoreStatus.loading) {
                return "Please wait";
              } else if (statue == LoadMoreStatus.nomore) {
                return "No More items";
              } else if (statue == LoadMoreStatus.fail) {
                return "Failed";
              } else if (statue == LoadMoreStatus.idle) {
                return "Ideal";
              }
              return "";
            },
            child: ListView.separated(
                separatorBuilder: (_, __) => Divider(),
                itemCount: ledgersList.length,
                itemBuilder: (context, postion) {
                  var item = ledgersList[postion];
                  var textTheme = Theme.of(context).textTheme;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransactionDetails(
                                    type: widget.type,
                                    id: item.getLeadingSubtitle().toString(),
                                    apiKey:
                                        companyRepo!.getSelectedUser().apiKey,
                                    fromDate: fromDate.toString(),
                                    todate: todate.toString(),
                                    title: widget.title,
                                    // RecNum: item.,
                                  )));
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  item.getLeadingTitle().toString() ,
                                  style: textTheme.subtitle1,
                                ),
                              ),
                              Text(
                                MyKey.currencyFromat(
                                    item.getTrailingTitle().toString(),
                                    decimmalPlace: 0),
                                style: textTheme.subtitle1!
                                    .copyWith(color: getColor(item)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.getLeadingSubtitle().toString() ?? "",
                                style: textTheme.caption,
                              ),
                              Text(item.getTrailingSubtitle() ?? "",
                                  style: textTheme.caption!
                                      .copyWith(color: getColor(item))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        )),
      ],
    );
  }

  Future<bool> getLedgers() async {
    // var dateFormater = DateFormat("dd/MM/yyyy");
    var date = DateTime.now();
    // var monthBigin = date.subtract(Duration(days: date.day - 1));
    fromDate = date.getFirstDayOfThisMonth.asString;
    todate = date.getLastDayOfThisMonth.asString;

    try {
      var data = await Serviece.getPartyLedger(
          context,
          companyRepo!.getSelectedUser().apiKey,
          widget.type,
          fromDate.toString(),
          todate.toString(),
          pageNo,
          query);
      // isLoading = false;
      ledgerHeadder = LedgerHeadderM.fromJson(data["Header"][0]);
      List lines = data["Lines"];
      fullList = lines.map((e) => LedgerM.fromJson(e)).toList();
      ledgersList.addAll(fullList!);
      if (widget.valueChanged != null) {
        widget.valueChanged!(ledgerHeadder!);
      } else {
        setState(() {});
      }
    } catch (e) {
      print(e);
      return false;
    }
    hasMoreData = fullList!.length > 0;
    return hasMoreData;
  }

  getColor(LedgerM item) =>
      item.balance! < 0 ? AppColor.negativeRed : AppColor.positiveGreen;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  String getStringFromType() {
    switch (widget.type) {
      case "C":
        return "Party";
        break;
      case "S":
        return "Supplier";
        break;
      case "A":
        return "Account";
        break;
      case "E":
        return "Employee";
        break;
      default:
        return "";
          }
  }
}
