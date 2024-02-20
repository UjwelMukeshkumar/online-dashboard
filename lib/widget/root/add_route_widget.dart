import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/library/DateFactory.dart';
import 'package:glowrpt/model/route/EmployeeM.dart';
import 'package:glowrpt/util/MyKey.dart';

class AddRouteWidget extends StatefulWidget {
  ValueChanged<RouteEmployeeM> onSave;
  List<RouteEmployeeM> employeeList;
  RouteEmployeeM selectedEmployee;
  TextEditingController etcRouteName;
  TextEditingController tecCount;
  TextEditingController frequency;
  TextEditingController tecDate;

  AddRouteWidget({
  required  this.onSave,
  required  this.employeeList,
  required  this.selectedEmployee,
  required  this.etcRouteName,
  required  this.tecCount,
  required  this.frequency,
  required  this.tecDate,
  });

  @override
  State<AddRouteWidget> createState() => _AddRouteWidgetState();
}

class _AddRouteWidgetState extends State<AddRouteWidget> {
   ValueChanged<RouteEmployeeM>? onEmployeeChange;

   RouteEmployeeM? selectedEmployeeForNewRoute;

  var timeController = TextEditingController();
  List<String> frequencyList = ["Monthly", "Weekly", "Daily"];
  List<String> frequencyDisplay = ["Month", "Week", "Day"];
   String? selectedFrequency;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedFrequency = frequencyList.first;
    widget.frequency.text = selectedFrequency.toString();
    widget.tecDate.text = selectedDate.asString;
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var space = SizedBox(
      height: 12,
    );
    return Container(
      width: 300.0,
      height: 450,
      child: Stack(
       clipBehavior: Clip.none,
        children: <Widget>[
          Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.cancel,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              )),
          Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Add New",
                style: textTheme.headline6,
              )),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownSearch<String>(
                     popupProps: PopupProps.modalBottomSheet(
                      showSearchBox: true,
                      isFilterOnline: true,
                      
                    ),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      
                        dropdownSearchDecoration: InputDecoration(
                      labelText: "Frequency",
                    )),
                    
                    // mode: Mode.BOTTOM_SHEET,
                    selectedItem: selectedFrequency,
                    items: frequencyList,
                    // label: "Frequency",
                    // isFilteredOnline: true,
                    onChanged: (item) {
                      setState(() {
                        selectedFrequency = item.toString();
                        widget.frequency.text = item.toString();
                      });
                    },
                    validator: (date) => date == null ? "Invalid data" : null,
                  ),
                  space,
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: widget.tecCount,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Every", border: textFieldBorder),
                        ),
                        flex: 4,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: Text(
                        "${frequencyDisplay[frequencyList.indexOf(selectedFrequency.toString())]}",
                        style: textTheme.caption,
                      ))
                    ],
                  ),
                  space,
                  DateTimeField(
                    decoration: InputDecoration(border: textFieldBorder),
                    mode: DateTimeFieldPickerMode.date,
                    dateFormat: MyKey.displayDateFormat,
                    selectedDate: selectedDate,
                    onDateSelected: (date) {
                      selectedDate = date;
                      widget.tecDate.text = date.asString;
                    },
                  ),
                  space,
                  DropdownSearch<RouteEmployeeM>(
                     popupProps: PopupProps.modalBottomSheet(
                      showSearchBox: true,
                      isFilterOnline: true,
                    ),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                   labelText: "Select Employee"
                    )),
                    // mode: Mode.BOTTOM_SHEET,
                    selectedItem: isFirstEmployee(widget.selectedEmployee)
                        ? null
                        : widget.selectedEmployee,
                    items: widget.employeeList.sublist(1),
                    // label: "Select Employee",
                    // isFilteredOnline: true,
                    // dropdownDecoratorProps: DropDownDecoratorProps(
                    //     dropdownSearchDecoration:
                    //         InputDecoration(labelText: "Select Employee")),
                    onChanged: (party) {
                      selectedEmployeeForNewRoute = party!;
                    },
                    validator: (date) => date == null ? "Invalid data" : null,
                  ),
                  space,
                  TextField(
                    controller: widget.etcRouteName,
                    decoration: InputDecoration(
                        labelText: "Route Name", border: textFieldBorder),
                  ),
                  space,
                ],
              ),
            ),
          ),
          Positioned(
              bottom: -20,
              left: 0,
              right: 0,
              child: FloatingActionButton(
                onPressed: () => widget.onSave(selectedEmployeeForNewRoute!),
                child: Icon(Icons.done),
                backgroundColor: Colors.blueAccent,
              ))
        ],
      ),
    );
  }

  bool isFirstEmployee(RouteEmployeeM employeeM) {
    return (employeeM.EmpCode == "0" &&
        employeeM.EmpId == "0" &&
        employeeM.EmpName == "All");
  }
}
