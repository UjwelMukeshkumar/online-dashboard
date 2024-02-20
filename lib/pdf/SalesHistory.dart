import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/model/other/DocM.dart';

class SalesHistory extends StatelessWidget {
  final Map item;

  const SalesHistory({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    print(item);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales History'),
        backgroundColor: Colors.blue, // You can change the color as per your design
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.white, // Set your desired background color
        child: Center(
          child: DataTable(
            columns: [
              DataColumn(label: Text('Attribute')),
              DataColumn(label: Text('Value')),
            ],
            rows: [
              buildDataRow('Item Number', item["Item_No"]),
              buildDataRow('Item Name', item["Item Name"]),
              buildDataRow('Quantity', item["Quantity"]),
              buildDataRow('Price', item["Price"]),
              buildDataRow('Net Total', item["Net Total"]),
              buildDataRow('Cost', item["Cost"]),
              buildDataRow('Tax Amount', item["TaxAmount"]),
            ],
          ),
        ),
      ),
    );
  }

  DataRow buildDataRow(String attribute, dynamic value) {
    return DataRow(
      cells: [
        DataCell(Text(attribute)),
        DataCell(Text('$value')),
      ],
    );
  }
}
