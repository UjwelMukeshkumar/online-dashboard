import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/party/PartySearchM.dart';
import 'package:glowrpt/model/route/EmployeeM.dart';
import 'package:glowrpt/model/route/RouteM.dart';
import 'package:glowrpt/repo/Provider.dart';
// import 'package:glowrpt/screen/route/select_route_screen1.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/Serviece.dart';
// import 'package:glowrpt/util/DataProvider.dart';
import 'package:provider/provider.dart';

// class RoutesScreenOrderable extends StatefulWidget {
// ignore: must_be_immutable
class RoutesScreenOrderable extends StatefulWidget {
  bool isManager;
  RouteM item;
  List<RouteEmployeeM> employeeList;
  List<RouteM> routesList;
  RoutesScreenOrderable({
   required this.isManager,
   required this.item,
   required this.employeeList,
   required this.routesList,
  });

  @override
  State<RoutesScreenOrderable> createState() => _RoutesScreenOrderableState();
}

class _RoutesScreenOrderableState extends State<RoutesScreenOrderable> {
  var selectedRoute;

   CompanyRepository? compRepo;

  PartySearchM? party1;
  List<String> _products = ["Shamsu", "Shihabe", "abdu", "ajith"];

  @override
  void initState() {
    super.initState();
    // selectedRoute = DataProvider.routes.first;
    compRepo = Provider.of<CompanyRepository>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(height: 16);
    return Scaffold(
      appBar: AppBar(
        title: Text("Routes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InkWell(
              child: Chip(
                  label: Text(
                      "${widget.item.RouteName} (${widget.item.EMPCode})")),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectRouteScreen1()));
              },
            ),
            space,
            /*   DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              showSearchBox: true,
              label: "Please Choose Route",
              items: DataProvider.routes,
              onChanged: (party) {

              },
              validator: (date)=>date==null? "Invalid data" : null,
            ),*/
            ListTile(
              title: Text("Select Route"),
            ),
            space,
            DropdownSearch<PartySearchM>(
              popupProps: PopupProps.bottomSheet(
                showSearchBox: true,
                isFilterOnline: true,
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                labelText: "Select Customer",
              )),
              asyncItems: (text) => Serviece.partySearch(
                  context: context,
                  api_key: compRepo!.getSelectedApiKey(),
                  Type: "E",
                  query: text),
              // mode: Mode.BOTTOM_SHEET,
              // showSearchBox: true,
              // label: "Select Customer",
              // isFilteredOnline: true,
              // onFind: (text) => Serviece.partySearch(
              //     context: context,
              //     api_key: compRepo.getSelectedApiKey(),
              //     Type: "E",
              //     query: text),
              onChanged: (party) {
                party1 = party;
                _products.add(party!.Name!);
              },
              validator: (date) => date == null ? "Invalid data" : null,
            ),
            space,
            Expanded(
              flex: 10,
              child: ReorderableListView.builder(
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final String productName = _products[index];
                    return Card(
                      key: ValueKey(productName),
                      color: AppColor.ligtBluePonePe,
                      elevation: 1,
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        title: Text(
                          productName,
                          style: const TextStyle(fontSize: 18),
                        ),
                        trailing: const Icon(Icons.drag_handle),
                        onTap: () {/* Do something else */},
                      ),
                    );
                  },
                  // The reorder function
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex = newIndex - 1;
                      }
                      final element = _products.removeAt(oldIndex);
                      _products.insert(newIndex, element);
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
