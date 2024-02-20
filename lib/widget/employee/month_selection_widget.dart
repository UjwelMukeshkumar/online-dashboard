import 'package:flutter/material.dart';
import 'package:glowrpt/service/DateService.dart';
import 'package:glowrpt/util/Constants.dart';
import 'package:glowrpt/util/MyKey.dart';

class MonthSelectionWidget extends StatefulWidget {
  ValueChanged<List<String>> valueChanged;
  List<String> initialDate;

  MonthSelectionWidget({
   required this.valueChanged,
   required this.initialDate,
  });

  @override
  State<MonthSelectionWidget> createState() => _MonthSelectionWidgetState();
}

List<String> years = [];
// var today=DateTime.now();
String? selectedYear;
int selectedMonth = 0;

class _MonthSelectionWidgetState extends State<MonthSelectionWidget> {
  @override
  void initState() {
    super.initState();
    var initDate = MyKey.displayDateFormat.parse(widget.initialDate.first);
    int currentYear = initDate.year;
    selectedYear = currentYear.toString();
    years = List.generate(10, (index) => (currentYear - 5) + index)
        .map((e) => e.toString())
        .toList();
    selectedMonth = initDate.month - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            DropdownButton(
                elevation: 0,
                underline: Container(),
                value: selectedYear,
                onChanged: (value) {
                  selectedYear = value;
                  whenDateChange();
                },
                items: years
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList()),
            Expanded(
                child: SizedBox(
              height: 30,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: DateService.Months.length,
                  itemBuilder: (context, position) {
                    var item = DateService.Months[position];
                    return InkWell(
                      onTap: () {
                        selectedMonth = position;
                        whenDateChange();
                      },
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal:8.0,vertical:4 ),
                        child: Text(
                          item,
                          style: TextStyle(
                              color: selectedMonth == position
                                  ? Colors.blue
                                  : AppColor.title),
                        ),
                    
                      ),
                    );
                  }),
            ))
          ],
        ),
      ],
    );
  }

  void whenDateChange() {
    var date = DateTime(int.parse(selectedYear!), selectedMonth);
    var binginDate = DateTime(date.year, date.month + 1, 1);
    var endDate = DateTime(date.year, date.month + 2, 0);
    widget.valueChanged([
      MyKey.displayDateFormat.format(binginDate),
      MyKey.displayDateFormat.format(endDate)
    ]);
  }
}
