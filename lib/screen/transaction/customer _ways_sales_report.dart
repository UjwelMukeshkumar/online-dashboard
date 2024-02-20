import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/CustomerWaysReportM.dart' as cos;
import 'package:glowrpt/model/other/CustomerWaysReportM.dart';
import 'package:glowrpt/model/party/PartySearchM.dart';
import 'package:glowrpt/model/party/SinglePartyDetailsM.dart';
import 'package:glowrpt/model/route/PlannerRouteLoadM.dart';
import 'package:glowrpt/model/transaction/DocumentLoadM.dart';
import 'package:glowrpt/repo/Provider.dart';
import 'package:glowrpt/util/MyKey.dart';
import 'package:glowrpt/util/Serviece.dart';
import 'package:provider/provider.dart';

class CustomerWaysSalesReport extends StatefulWidget {
  RouteDetailsBean? rootDetails;

  CustomerWaysSalesReport({
    super.key,
  });

  @override
  State<CustomerWaysSalesReport> createState() =>
      _CustomerWaysSalesReportState();
}

class _CustomerWaysSalesReportState extends State<CustomerWaysSalesReport> {
  SinglePartyDetailsM? party;
  CompanyRepository? compRepo;
  PartySearchM? selectedParty;
  CustomerWaysSalesReportM? customerReport;
  // List<cos.Table> itemList = [];

  List<String> optionsFindBy = ["Search", "QR scan"];
  String? option;

  DocumentLoadM? documentLoadM;

  // Declare itemList here
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
  }

  void fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      if (selectedParty != null) {
        var responseData = await Serviece.getCustomerwaysReport(
          apiKey: compRepo!.getSelectedApiKey(),
          context: context,
          cvCode: selectedParty!.CVCode.toString(),
        );

        setState(() {
          if (responseData != null) {
            isLoading = false;
            // Check if responseData.table is a List<dynamic>
            if (responseData.table is List<dynamic>) {
              // Use the List directly
              customerReport =
                  CustomerWaysSalesReportM(table: responseData.table);
            } else {
              // Handle the case when responseData.table is not a List
              // Maybe display an error message or set a default value
              customerReport = CustomerWaysSalesReportM(table: []);
            }
          } else {
            // Handle the case when responseData is null
            customerReport = CustomerWaysSalesReportM(table: []);
          }
        });
      } else {
        // Handle case when no party is selected
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
      // Handle the error or notify the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Ways Sales Report"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownSearch<PartySearchM>(
              popupProps: PopupProps.menu(
                showSearchBox: true,
                isFilterOnline: true,
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                hintText: "${party?.CVName ?? "Select Customer"}",
              )),
              asyncItems: (text) => Serviece.partySearch(
                  context: context,
                  api_key: compRepo!.getSelectedApiKey(),
                  Type: "C",
                  query: text),
              enabled: widget.rootDetails == null,
              // mode: Mode.MENU,
              selectedItem: selectedParty,

              onChanged: (party) {
                selectedParty = party;
                fetchData();
                getSinglePartyDetails(party?.CVCode.toString());
              },
              // itemAsString: (PartySearchM party) =>party.CVName??"",
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            title: Text(
              "Item Name",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            trailing: Text(
              "Item No",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          Divider(),
          Expanded(
            child: isLoading
                ? Center(
                    child: CupertinoActivityIndicator(),
                  )
                : customerReport != null
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: customerReport?.table.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                  "${customerReport?.table[index].itemName}"),
                              trailing: Text(
                                  "${customerReport?.table[index].itemNo}"),
                            ),
                          );
                        },
                      )
                    : selectedParty == null
                        ? Center(
                            child: Text("Select Customer..."),
                          )
                        : Center(
                            child: Text("No Data available"),
                          ),
          )
        ],
      ),
    );
  }

  void getSinglePartyDetails(String? cvCode) async {
    if (cvCode != null) {
      this.party = await Serviece.getSinglePartyDetails(
        apiKey: compRepo!.getSelectedApiKey(),
        cvCode: cvCode.toString(),
        context: context,
      );
      if (party != null) {
        // if (selectedItemList.isEmpty) {
        //   startItemWindowFromSearch();
        // }
        setState(() {});
      }
    }
  }
}
